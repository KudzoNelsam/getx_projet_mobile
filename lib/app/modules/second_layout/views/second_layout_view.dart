import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/second_layout_controller.dart';

class SecondLayoutView extends GetView<SecondLayoutController> {
  final Widget body;
  final AppBar appBar;
  final BottomNavigationBar navigationBar;
  const SecondLayoutView({
    super.key,
    required this.body,
    required this.appBar,
    required this.navigationBar,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: navigationBar,
    );
  }
}
