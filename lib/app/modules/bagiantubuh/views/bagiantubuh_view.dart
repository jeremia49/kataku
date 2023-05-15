import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kataku/app/components/item_builder.dart';
import 'package:kataku/app/modules/bagiantubuh/views/const_bagiantubuh.dart';

import '../controllers/bagiantubuh_controller.dart';

class BagiantubuhView extends GetView<BagiantubuhController> {
  const BagiantubuhView({Key? key}) : super(key: key);
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
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/images/btn_bagiantubuh.jpg",
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ImageButtonItemBuilder(BAGIANTUBUH, BAGIANTUBUHList),
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
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}