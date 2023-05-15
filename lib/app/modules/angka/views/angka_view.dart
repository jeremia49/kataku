import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/angka_controller.dart';

class AngkaView extends GetView<AngkaController> {
  const AngkaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AngkaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AngkaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
