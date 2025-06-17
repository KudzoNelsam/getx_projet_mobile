import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:get/get.dart';

class DettesListController extends GetxController {
  final DetteService detteService = Get.find();
  final ClientService clientService = Get.find();

  var dettes = [].obs;
  var clients = [].obs;
  var isLoading = false.obs;
  var selectedClientId = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchClients();
    fetchDettes();
  }

  Future<void> fetchClients() async {
    try {
      final response = await clientService.getClients();
      if (response.statusCode == 200) {
        clients.value = response.data;
      } else {
        clients.value = [];
      }
    } catch (e) {
      clients.value = [];
    }
  }

  Future<void> fetchDettes() async {
    isLoading.value = true;
    try {
      final response = await detteService.getAllDettes(
        clientId: selectedClientId.value,
      );
      if (response.statusCode == 200) {
        dettes.value = response.data;
      } else {
        dettes.value = [];
      }
    } catch (e) {
      dettes.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void filterByClient(int? clientId) {
    selectedClientId.value = clientId;
    fetchDettes();
  }
}
