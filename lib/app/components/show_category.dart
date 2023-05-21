import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kataku/app/components/item_builder.dart';

class showCategory extends StatefulWidget {
  final String categoryImage;
  final String categoryName;
  const showCategory(this.categoryName, this.categoryImage, {super.key});

  @override
  State<showCategory> createState() => _showCategoryState();
}

class _showCategoryState extends State<showCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset("assets/images/bg_base.jpg"),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.file(
                    File(widget.categoryImage),
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child:
                      ImageButtonItemBuilder(widget.categoryName, List.empty()),
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
      backgroundColor: const Color.fromARGB(255, 255, 246, 129),
    );
  }
}
