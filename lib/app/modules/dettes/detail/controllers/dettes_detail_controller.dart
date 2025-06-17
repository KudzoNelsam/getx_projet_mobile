import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:default_projec/app/services/impl/ligne_service.dart';
import 'package:default_projec/app/services/impl/paiement_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DettesDetailController extends GetxController {
  final DetteService detteService = Get.find();
  final PaiementService paiementService = Get.find();
  final LigneService ligneService = Get.find();
  final ClientService clientService = Get.find();

  var dette = {}.obs;
  var client = {}.obs;
  var paiements = [].obs;
  var lignes = [].obs;

  var isLoading = false.obs;
  var isLoadingPaiement = false.obs;

  final paiementController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? detteId;

  @override
  void onInit() {
    super.onInit();
    detteId = Get.arguments?['detteId']?.toString();
    if (detteId != null) {
      fetchAll();
    }
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      await fetchDette();
      await fetchClient();
      await fetchLignes();
      await fetchPaiements();
    } catch (e) {
      Get.snackbar("Erreur", "Impossible de charger les détails de la dette");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDette() async {
    final res = await detteService.getDetteById(detteId!);
    if (res.statusCode == 200 && res.data != null) {
      dette.value = res.data;
    } else {
      dette.value = {};
    }
  }

  Future<void> fetchClient() async {
    final clientId = dette['clientId']?.toString();
    if (clientId != null) {
      final res = await clientService.getClientById(clientId);
      if (res.statusCode == 200 && res.data != null) {
        client.value = res.data;
      } else {
        client.value = {};
      }
    }
  }

  Future<void> fetchLignes() async {
    final res = await ligneService.getLignesByDetteId(detteId!);
    if (res.statusCode == 200 && res.data != null) {
      lignes.value = res.data;
    } else {
      lignes.value = [];
    }
  }

  Future<void> fetchPaiements() async {
    final res = await paiementService.getPaiementsByDetteId(detteId!);
    if (res.statusCode == 200 && res.data != null) {
      paiements.value = res.data;
    } else {
      paiements.value = [];
    }
  }

  double get montantRestant {
    final montantDette = double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
    final montantPaye = double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
    return (montantDette - montantPaye).clamp(0, montantDette);
  }

  bool get isDettePayee => montantRestant <= 0.0;

  double get pourcentagePaye {
    final montantDette = double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
    final montantPaye = double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
    if (montantDette == 0) return 0;
    return (montantPaye / montantDette) * 100;
  }

  Future<void> enregistrerPaiement() async {
    if (!formKey.currentState!.validate()) return;

    final montant = double.tryParse(paiementController.text) ?? 0;
    if (montant <= 0 || montant > montantRestant) {
      Get.snackbar("Erreur", "Montant invalide");
      return;
    }

    isLoadingPaiement.value = true;
    try {
      // Création du paiement
      final response = await paiementService.createPaiement({
        'date': DateTime.now().toIso8601String().split('T').first,
        'montantVerse': montant,
        'clientId': dette['clientId']?.toString(),
        'detteId': detteId,
      });

      if (response.statusCode == 201) {
        // CORRECTION: Mettre à jour localement les valeurs sans remplacer la structure
        final montantPaye = double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
        final montantDette = double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
        final nouveauMontantPaye = montantPaye + montant;
        final nouveauMontantRestant = (montantDette - nouveauMontantPaye).clamp(0, montantDette);

        // Mettre à jour la dette côté backend
        await detteService.updateDette(detteId!, {
          'montantPaye': nouveauMontantPaye,
          'montantRestant': nouveauMontantRestant,
        });

        // CORRECTION: Mettre à jour uniquement les valeurs modifiées sans refetch complet
        // Préserver la structure existante et ne modifier que les champs nécessaires
        Map<String, dynamic> updatedDette = Map<String, dynamic>.from(dette.value);
        updatedDette['montantPaye'] = nouveauMontantPaye;
        updatedDette['montantRestant'] = nouveauMontantRestant;
        dette.value = updatedDette;

        // Ajouter le nouveau paiement à la liste existante
        final nouveauPaiement = {
          'id': response.data['id'], // L'ID retourné par l'API
          'date': DateTime.now().toIso8601String().split('T').first,
          'montantVerse': montant,
          'clientId': dette['clientId']?.toString(),
          'detteId': detteId,
        };
        
        // Ajouter le nouveau paiement au début de la liste
        List<dynamic> updatedPaiements = [nouveauPaiement, ...paiements.value];
        paiements.value = updatedPaiements;

        paiementController.clear();
        Get.snackbar("Succès", "Paiement enregistré avec succès !");
      } else {
        Get.snackbar("Erreur", "Impossible d'enregistrer le paiement");
      }
    } catch (e) {
      Get.snackbar("Erreur", "Une erreur est survenue");
      print("Erreur lors de l'enregistrement du paiement: $e");
    } finally {
      isLoadingPaiement.value = false;
    }
  }

  // Méthode pour refresh manuellement si nécessaire
  Future<void> refreshData() async {
    await fetchAll();
  }

  @override
  void onClose() {
    paiementController.dispose();
    super.onClose();
  }
}