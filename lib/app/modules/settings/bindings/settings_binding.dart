import 'package:default_projec/app/modules/main_layout/controllers/main_layout_controller.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());

    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
  }
}
