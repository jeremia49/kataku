import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kataku/app/components/new_category.dart';
import 'package:kataku/app/components/remember_input.dart';
import 'package:kataku/app/components/show_category.dart';
import 'package:kataku/app/modules/mainmenu/views/const_mainmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              mainAxisSize: MainAxisSize.min,
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
                MainMenuListWidget(mainMenuList),
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

class MainMenuListWidget extends StatefulWidget {
  final List<MainMenuItem> originalItem;
  const MainMenuListWidget(this.originalItem, {super.key});

  @override
  State<MainMenuListWidget> createState() => _MainMenuListWidgetState();
}

class _MainMenuListWidgetState extends State<MainMenuListWidget> {
  SharedPreferences? prefs;
  List<Map<String, String>> userAdd = List.empty(
    growable: true,
  );

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
    // prefs!.setString('user-${widget.category}', encodedMap);
    final String? useradd = prefs!.getString('category');
    if (useradd == null) return;

    final List<dynamic> listUserAdd = json.decode(useradd);
    for (var el in listUserAdd) {
      Map<String, String> map = el.cast<String, String>();
      userAdd.add(map);
    }
    setState(() {});
    // userAdd = json.decode(useradd) as List<Map<String, String>>;
    print(userAdd);
    // userAdd
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext ctx, int index) {
          if (index < widget.originalItem.length) {
            return InkWell(
              onTap: () {
                Get.toNamed(widget.originalItem[index].hyperlink);
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  widget.originalItem[index].imgpath,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            );
          }
          if (index < widget.originalItem.length + userAdd.length) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => showCategory(
                      userAdd[index - widget.originalItem.length].keys.first,
                      userAdd[index - widget.originalItem.length].values.first,
                    ),
                  ),
                );
                // Nama : userAdd[index - widget.data.length].keys.first
                // Data gambar : userAdd[index - widget.originalItem.length].values.first
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.file(
                  File(
                      userAdd[index - widget.originalItem.length].values.first),
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            );
          }
          return AddCategoryButton(userAdd, () {
            setState(() {});
          });
        },
        itemCount: widget.originalItem.length + userAdd.length + 1,
      ),
    );
  }
}
