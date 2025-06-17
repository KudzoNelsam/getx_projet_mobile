import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsFormController extends GetxController {
 final ClientService service = Get.find();

  final formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();

  var isLoading = false.obs;
  String? clientId;

  @override
  void onInit() {
    super.onInit();
    // Pour l'édition, on récupère les arguments éventuels
    final args = Get.arguments;
    if (args != null && args is Map && args['client'] != null) {
      final client = args['client'];
      clientId = client['id'];
      nomController.text = client['nom'] ?? '';
      telephoneController.text = client['telephone'] ?? '';
      adresseController.text = client['adresse'] ?? '';
    }
  }

  @override
  void onClose() {
    nomController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    final data = {
      'nom': nomController.text.trim(),
      'telephone': telephoneController.text.trim(),
      'adresse': adresseController.text.trim(),
    };
    try {
      if (clientId == null) {
        // Création
        final response = await service.createClient(data);
        if (response.statusCode == 201) {
          Get.back();
          Get.snackbar('Succès', 'Client ajouté avec succès');
        } else {
          Get.snackbar('Erreur', 'Impossible d\'ajouter le client');
        }
      } else {
        // Edition
        final response = await service.updateClient(clientId!, data);
        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar('Succès', 'Client modifié avec succès');
        } else {
          Get.snackbar('Erreur', 'Impossible de modifier le client');
        }
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue');
    } finally {
      isLoading.value = false;
    }
  }
}
