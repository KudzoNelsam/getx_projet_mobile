import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dettes_detail_controller.dart';

class DettesDetailView extends GetView<DettesDetailController> {
  const DettesDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DettesDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DettesDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
