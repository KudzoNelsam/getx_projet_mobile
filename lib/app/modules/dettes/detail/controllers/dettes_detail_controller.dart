import 'package:default_projec/app/data/dette_model.dart';
import 'package:default_projec/app/services/impl/article_service.dart';
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
  final ArticleService articleService = Get.find();

  var dette = {}.obs;
  var client = {}.obs;
  var paiements = [].obs;
  var lignes = [].obs;
  var articles = [].obs;

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
      // IMPORTANT: Charger les articles en premier pour avoir les données de référence
      await fetchArticles();
      await fetchDette();
      await fetchClient();
      await fetchLignes();
      await fetchPaiements();
    } catch (e) {
      Get.snackbar("Erreur", "Impossible de charger les détails de la dette");
      print("Erreur fetchAll: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDette() async {
    try {
      final res = await detteService.getDetteById(detteId!);
      if (res.statusCode == 200 && res.data != null) {
        dette.value = res.data;
        print("Dette chargée: ${dette.value}"); // Debug
      } else {
        dette.value = {};
        print("Erreur chargement dette: ${res.statusCode}");
      }
    } catch (e) {
      dette.value = {};
      print("Exception fetchDette: $e");
    }
  }

  Future<void> fetchArticles() async {
    try {
      final res = await articleService.getAllArticles();
      if (res.statusCode == 200 && res.data != null) {
        articles.value = res.data;
        print("Articles chargés: ${articles.length} articles"); // Debug
      } else {
        articles.value = [];
        print("Erreur chargement articles: ${res.statusCode}");
      }
    } catch (e) {
      articles.value = [];
      print("Exception fetchArticles: $e");
    }
  }

  // CORRECTION: Méthode plus robuste pour récupérer un article
  Map<String, dynamic> getArticleById(dynamic id) {
    final article = articles.firstWhereOrNull(
      (a) => a['id'].toString() == id.toString(),
    );
    if (article == null) {
      print("Article non trouvé pour ID: $id");
      // Retourner un article par défaut pour éviter les erreurs
      return {'id': id, 'libelle': 'Article inconnu', 'prixVente': 0.0};
    }
    return article;
  }

  Future<void> fetchClient() async {
    final clientId = dette['clientId']?.toString();
    if (clientId != null) {
      try {
        final res = await clientService.getClientById(clientId);
        if (res.statusCode == 200 && res.data != null) {
          client.value = res.data;
        } else {
          client.value = {};
        }
      } catch (e) {
        client.value = {};
        print("Exception fetchClient: $e");
      }
    }
  }

  Future<void> fetchLignes() async {
    try {
      final res = await ligneService.getLignesByDetteId(detteId!);
      if (res.statusCode == 200 && res.data != null) {
        lignes.value = res.data;
        print("Lignes chargées: ${lignes.length} lignes"); // Debug
      } else {
        lignes.value = [];
      }
    } catch (e) {
      lignes.value = [];
      print("Exception fetchLignes: $e");
    }
  }

  Future<void> fetchPaiements() async {
    try {
      final res = await paiementService.getPaiementsByDetteId(detteId!);
      if (res.statusCode == 200 && res.data != null) {
        paiements.value = res.data;
        print("Paiements chargés: ${paiements.length} paiements"); // Debug
      } else {
        paiements.value = [];
      }
    } catch (e) {
      paiements.value = [];
      print("Exception fetchPaiements: $e");
    }
  }

  num get montantRestant {
    final montantDette =
        double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
    final montantPaye =
        double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
    final restant = (montantDette - montantPaye).clamp(0, montantDette);
    return restant;
  }

  bool get isDettePayee =>
      montantRestant <= 0.01; // Tolérance pour les erreurs d'arrondi

  double get pourcentagePaye {
    final montantDette =
        double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
    final montantPaye =
        double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
    if (montantDette == 0) return 0;
    return ((montantPaye / montantDette) * 100).clamp(0, 100);
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
        final montantPaye =
            double.tryParse(dette['montantPaye']?.toString() ?? '0') ?? 0.0;
        final montantDette =
            double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0;
        final nouveauMontantPaye = montantPaye + montant;
        final nouveauMontantRestant = (montantDette - nouveauMontantPaye).clamp(
          0,
          montantDette,
        );

        final updatedDette = Dette(
          id: dette['id'],
          date: DateTime.parse(dette['date']),
          montantDette:
              double.tryParse(dette['montantDette']?.toString() ?? '0') ?? 0.0,
          montantPaye: nouveauMontantPaye,
          montantRestant: double.tryParse(
            nouveauMontantRestant.toString(),
          ) ?? 0.0,
          clientId: dette['clientId'],
        );
        // Mettre à jour la dette côté backend
        final updateResponse = await detteService.updateDette(detteId!, updatedDette.toJson());

        if (updateResponse.statusCode == 200) {
          // Mettre à jour localement SEULEMENT si la mise à jour backend réussit
          Map<String, dynamic> updatedDette = Map<String, dynamic>.from(
            dette.value,
          );
          updatedDette['montantPaye'] = nouveauMontantPaye;
          updatedDette['montantRestant'] = nouveauMontantRestant;
          dette.value = updatedDette;

          // Ajouter le nouveau paiement à la liste
          final nouveauPaiement = {
            'id': response.data['id'],
            'date': DateTime.now().toIso8601String().split('T').first,
            'montantVerse': montant,
            'clientId': dette['clientId']?.toString(),
            'detteId': detteId,
          };

          List<dynamic> updatedPaiements = [
            nouveauPaiement,
            ...paiements.value,
          ];
          paiements.value = updatedPaiements;

          paiementController.clear();
          Get.snackbar("Succès", "Paiement enregistré avec succès !");
        } else {
          throw Exception("Échec de la mise à jour de la dette");
        }
      } else {
        Get.snackbar("Erreur", "Impossible d'enregistrer le paiement");
      }
    } catch (e) {
      Get.snackbar("Erreur", "Une erreur est survenue: $e");
      print("Erreur lors de l'enregistrement du paiement: $e");
      // IMPORTANT: En cas d'erreur, recharger les données pour être sûr
      await fetchDette();
      await fetchPaiements();
    } finally {
      isLoadingPaiement.value = false;
    }
  }

  @override
  void onClose() {
    paiementController.dispose();
    super.onClose();
  }
}
