import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kataku/app/components/remember_input.dart';

import '../../../components/add_btn.dart';
import '../controllers/mainmenu_controller.dart';

class MainmenuView extends GetView<MainmenuController> {
  MainmenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  child: RememberTextField("Nama"),
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
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_keluarga.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/aktivitas');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/buah');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_buah.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/perasaan');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/hewan');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_hewan.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/bagiantubuh');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/warna');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_warna.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/bentuk');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/pakaian');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_pakaian.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/rumah');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/sekolah');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_sekolah.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/angka');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
                      onTap: () {
                        Get.toNamed('/huruf');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/btn_huruf.jpg",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur Belum Selesai  !'),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/add_btn.png",
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
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
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}
