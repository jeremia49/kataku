import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mainmenu_controller.dart';

class MainmenuView extends GetView<MainmenuController> {
  const MainmenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset("assets/images/bg_base.jpg"),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 246, 129),
    );
  }
}
