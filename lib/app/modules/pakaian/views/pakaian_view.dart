import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kataku/app/components/item_builder.dart';
import 'package:kataku/app/modules/pakaian/views/const_pakaian.dart';

import '../controllers/pakaian_controller.dart';

class PakaianView extends GetView<PakaianController> {
  const PakaianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset("assets/images/bg_base.jpg"),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/images/btn_pakaian.jpg",
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ImageButtonItemBuilder(PAKAIAN, PAKAIANList),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset("assets/images/home_btn.png"),
              iconSize: 50,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 246, 129),
    );
  }
}
