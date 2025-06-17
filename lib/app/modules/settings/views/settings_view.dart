import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      body: const Center(
        child: Text('SettingsView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
