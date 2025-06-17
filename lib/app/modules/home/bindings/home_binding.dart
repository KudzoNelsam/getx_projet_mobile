import 'package:default_projec/app/modules/main_layout/controllers/main_layout_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
  }
}
