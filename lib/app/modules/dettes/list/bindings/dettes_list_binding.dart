import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:get/get.dart';

import '../controllers/dettes_list_controller.dart';

class DettesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DettesListController>(
      () => DettesListController(),
    );
     Get.lazyPut<DetteService>(
      () => DetteService(ApiConstants.baseUrl),
    );
     Get.lazyPut<ClientService>(
      () => ClientService(ApiConstants.baseUrl),
    );
  }
}
