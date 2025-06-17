import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/impl/article_service.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:default_projec/app/services/impl/ligne_service.dart';
import 'package:default_projec/app/services/impl/paiement_service.dart';
import 'package:get/get.dart';

import '../controllers/dettes_detail_controller.dart';

class DettesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DettesDetailController>(
      () => DettesDetailController(),
    );
    Get.lazyPut<DetteService>(
      () => DetteService(ApiConstants.baseUrl),
    );
     Get.lazyPut<PaiementService>(
      () => PaiementService(ApiConstants.baseUrl),
    );
     Get.lazyPut<ClientService>(
      () => ClientService(ApiConstants.baseUrl),
    );
     Get.lazyPut<LigneService>(
      () => LigneService(ApiConstants.baseUrl),
    );
     Get.lazyPut<ArticleService>(
      () => ArticleService(ApiConstants.baseUrl),
    );
  }
}
