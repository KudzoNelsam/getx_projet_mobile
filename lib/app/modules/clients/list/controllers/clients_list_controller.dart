import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsListController extends GetxController {
 final ClientService service = Get.find();

  var clients = [].obs;
  var isLoading = false.obs;

  // Controller pour le champ de recherche
  final TextEditingController searchController = TextEditingController();

  // Pour le filtre de recherche
  Future<void> fetchClients({String? nom}) async {
    isLoading.value = true;
    try {
      final response = await service.getClients(nom: nom);
      if (response.statusCode == 200) {
        clients.value = response.data;
      } else {
        clients.value = [];
      }
    } catch (e) {
      clients.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch() {
    fetchClients(nom: searchController.text);
  }

  @override
  void onInit() {
    super.onInit();
    fetchClients();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
void onReady() {
  super.onReady();
  fetchClients();
}
}
