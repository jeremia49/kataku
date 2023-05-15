import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/huruf_controller.dart';

class HurufView extends GetView<HurufController> {
  const HurufView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HurufView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HurufView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
