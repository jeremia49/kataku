import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bentuk_controller.dart';

class BentukView extends GetView<BentukController> {
  const BentukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BentukView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BentukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
