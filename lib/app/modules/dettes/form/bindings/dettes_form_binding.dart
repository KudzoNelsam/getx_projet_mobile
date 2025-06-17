import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/impl/article_service.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:default_projec/app/services/impl/ligne_service.dart';
import 'package:get/get.dart';

import '../controllers/dettes_form_controller.dart';

class DettesFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DettesFormController>(
      () => DettesFormController(),
    );
       Get.lazyPut<ClientService>(
      () => ClientService(ApiConstants.baseUrl),
    );
    Get.lazyPut(() => ArticleService(ApiConstants.baseUrl));
    Get.lazyPut(() => LigneService(ApiConstants.baseUrl));
    Get.lazyPut(() => DetteService(ApiConstants.baseUrl));
  }
}
