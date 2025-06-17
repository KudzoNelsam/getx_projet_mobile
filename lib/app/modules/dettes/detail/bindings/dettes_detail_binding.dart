import 'package:get/get.dart';

import '../controllers/dettes_detail_controller.dart';

class DettesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DettesDetailController>(
      () => DettesDetailController(),
    );
  }
}
