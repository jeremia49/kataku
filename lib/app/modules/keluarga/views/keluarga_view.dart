
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kataku/app/components/item_builder.dart';
import 'package:kataku/app/components/new_item.dart';
import 'package:kataku/app/components/remember_input.dart';

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
              child: keluargaWidget(controller),
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
      backgroundColor: const Color.fromARGB(255, 255, 246, 129),
    );
  }
}

class keluargaWidget extends StatefulWidget {
  final dynamic controller;
  const keluargaWidget(this.controller, {super.key});

  @override
  State<keluargaWidget> createState() => _keluargaWidgetState();
}

class _keluargaWidgetState extends State<keluargaWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/images/btn_keluarga.jpg",
            width: MediaQuery.of(context).size.width * 0.35,
          ),
          const SizedBox(
            height: 20,
          ),
          const KeluargaMember("Ayah"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Ibu"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Kakek"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Nenek"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Paman"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Bibi"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Tante"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Saudara Laki Laki"),
          const SizedBox(
            height: 5,
          ),
          const KeluargaMember("Saudara Perempuan"),
          const SizedBox(
            height: 5,
          ),
          ...() {
            List<Widget> a = List.empty(growable: true);
            for (var member in widget.controller.userAdd) {
              a.add(KeluargaMember(
                member.keys.first,
                pathGambar: member.values.first,
                isFromAsset: false,
              ));
              a.add(const SizedBox(height: 5));
            }
            return a;
          }(),
          AddNewItemButton(
            'KELUARGA',
            widget.controller.userAdd,
            () {
              setState(() {});
            },
            scale: 0.3,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class KeluargaMember extends StatelessWidget {
  final String nama;
  final String pathGambar;
  final bool isFromAsset;
  const KeluargaMember(this.nama,
      {this.pathGambar = "assets/images/add_btn.png",
      this.isFromAsset = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ImageClassExtended(
            "KELUARGA",
            nama,
            pathGambar,
            isFromAsset: isFromAsset,
            width: 0.3,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RememberTextField(nama),
          ),
        ),
      ],
    );
  }
}
