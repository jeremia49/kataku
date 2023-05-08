import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kataku/app/components/add_btn.dart';
import 'package:kataku/app/components/remember_input.dart';
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
                  KeluargaMember("Ayah"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Ibu"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Kakek"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Nenek"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Paman"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Bibi"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Tante"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Saudara Laki Laki"),
                  SizedBox(
                    height: 5,
                  ),
                  KeluargaMember("Saudara Perempuan"),
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

class KeluargaMember extends StatelessWidget {
  final String nama;
  const KeluargaMember(this.nama, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: AddBTNImage(nama.toLowerCase()),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RememberTextField(nama),
          ),
        ),
      ],
    );
  }
}
