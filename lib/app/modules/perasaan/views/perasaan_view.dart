import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kataku/app/components/item_builder.dart';
import 'package:kataku/app/components/new_item.dart';
import 'package:kataku/app/components/remember_input.dart';

import '../controllers/perasaan_controller.dart';

class PerasaanView extends GetView<PerasaanController> {
  const PerasaanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset("assets/images/bg_base.jpg"),
            SingleChildScrollView(
              child: perasaanWidget(controller),
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

class perasaanWidget extends StatefulWidget {
  final dynamic controller;
  const perasaanWidget(this.controller, {super.key});

  @override
  State<perasaanWidget> createState() => _perasaanWidgetState();
}

class _perasaanWidgetState extends State<perasaanWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/images/btn_perasaan.jpg",
            width: MediaQuery.of(context).size.width * 0.35,
          ),
          SizedBox(
            height: 20,
          ),
          KeluargaMember(
            "Senang",
            audioSrc: "sounds/senang.mp3",
          ),
          SizedBox(
            height: 5,
          ),
          KeluargaMember(
            "Sedih",
            audioSrc: "sounds/sedih.mp3",
          ),
          SizedBox(
            height: 5,
          ),
          KeluargaMember(
            "Marah",
            audioSrc: "sounds/marah.mp3",
          ),
          SizedBox(
            height: 5,
          ),
          KeluargaMember(
            "Menangis",
            audioSrc: "sounds/menangis.mp3",
          ),
          SizedBox(
            height: 5,
          ),
          KeluargaMember(
            "Malu",
            audioSrc: "sounds/malu.mp3",
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
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
            'PERASAAN',
            widget.controller.userAdd,
            () {
              setState(() {});
            },
            scale: 0.3,
          ),
          SizedBox(
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
  final String audioSrc;
  const KeluargaMember(this.nama,
      {this.pathGambar = "assets/images/add_btn.png",
      this.isFromAsset = true,
      this.audioSrc = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: ImageClassExtended(
            "PERASAAAN",
            nama,
            pathGambar,
            isFromAsset: isFromAsset,
            width: 0.3,
            audioSrcItem: audioSrc,
          ),
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
