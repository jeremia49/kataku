import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pakaian_controller.dart';

class PakaianView extends GetView<PakaianController> {
  const PakaianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PakaianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PakaianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
