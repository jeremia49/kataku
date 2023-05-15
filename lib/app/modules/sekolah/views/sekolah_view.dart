import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sekolah_controller.dart';

class SekolahView extends GetView<SekolahController> {
  const SekolahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SekolahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SekolahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
