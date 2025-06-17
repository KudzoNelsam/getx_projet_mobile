import 'package:get/get.dart';

import '../controllers/second_layout_controller.dart';

class SecondLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondLayoutController>(
      () => SecondLayoutController(),
    );
  }
}
