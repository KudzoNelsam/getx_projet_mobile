import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      body: Center(child: Text("Home View is working", style: TextStyle(
        fontSize: 20
      ),)),
      
    );
  }
}
