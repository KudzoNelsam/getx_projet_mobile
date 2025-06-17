import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:get/get.dart';

import '../controllers/clients_list_controller.dart';

class ClientsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientsListController>(
      () => ClientsListController(),
    );
     Get.lazyPut<ClientService>(
      () => ClientService(ApiConstants.baseUrl),
    );
    
  }
}
