import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/keluarga');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/add_btn.png",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 145, 140, 140),
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Nama',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
