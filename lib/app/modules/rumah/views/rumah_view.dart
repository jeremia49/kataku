import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rumah_controller.dart';

class RumahView extends GetView<RumahController> {
  const RumahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RumahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RumahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
