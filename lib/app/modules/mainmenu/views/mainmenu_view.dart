import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/add_btn.dart';
import '../controllers/mainmenu_controller.dart';

class MainmenuView extends GetView<MainmenuController> {
  MainmenuView({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();

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
                  AddBTNImage("myimage"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(50, 145, 140, 140),
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Nama',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/keluarga');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_keluarga.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_aktivitas.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_buah.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_perasaan.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_hewan.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_bagiantubuh.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_warna.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_bentuk.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_pakaian.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_rumah.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_sekolah.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_angka.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/btn_huruf.jpg",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/add_btn.png",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
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
