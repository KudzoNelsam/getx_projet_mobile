import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_layout_controller.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  final Widget body;
  final Widget? drawer;
  final AppBar? appBar;
  final List<BottomNavigationBarItem>? items;
  final FloatingActionButton? floatingActionButton;
  const MainLayoutView({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.items,
    this.floatingActionButton,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar ?? AppBar(title: Text("Default AppBar"), centerTitle: true),
      body: body,
      drawer: drawer ?? controller.buildDrawer(),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            controller.navigateTo(value);
          },
          currentIndex: controller.getCurrentIndex(),
          items: controller.getBottomNavigationBarItems(),
        ),
      ),
    );
  }
}
