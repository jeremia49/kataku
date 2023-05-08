import 'package:flutter/material.dart';

class ShowItemImage extends StatelessWidget {
  final String namaItem;
  final String gambarItem;
  const ShowItemImage(this.namaItem, this.gambarItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset("assets/images/bg_base.jpg"),
            Padding(
              padding: EdgeInsets.only(
                top: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/btn_keluarga.jpg",
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    namaItem,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      print("ditekan");
                    },
                    child: Icon(
                      Icons.volume_up_rounded,
                      size: 100,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
