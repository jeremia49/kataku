import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset("assets/images/bg_main_menu.jpg"),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(50, 50)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 139, 87, 42),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 139, 87, 42),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Get.toNamed('/mainmenu');
              },
              child: const Text(
                "Play Now",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(50, 50)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 139, 87, 42),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Color.fromARGB(255, 139, 87, 42),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Get.toNamed('/panduan');
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Panduan",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 248, 219, 83),
    );
  }
}
