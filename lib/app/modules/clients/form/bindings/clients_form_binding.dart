import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:get/get.dart';

import '../controllers/clients_form_controller.dart';

class ClientsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientsFormController>(
      () => ClientsFormController(),
    );
      Get.lazyPut<ClientService>(
      () => ClientService(ApiConstants.baseUrl),
    );
  }
}
