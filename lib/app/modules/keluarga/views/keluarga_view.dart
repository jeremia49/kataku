import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kataku/app/components/add_btn.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/keluarga_controller.dart';

class KeluargaView extends GetView<KeluargaController> {
  const KeluargaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset("assets/images/bg_base.jpg"),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/btn_keluarga.jpg",
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: AddBTNImage("ayah"),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(50, 145, 140, 140),
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: 'Nama',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
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
      ),
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}
