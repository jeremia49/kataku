import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeluargaController extends GetxController {
  SharedPreferences? prefs;
  var userAdd = List.empty(
    growable: true,
  ).obs;

  @override
  void onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
    // prefs!.setString('user-${widget.category}', encodedMap);
    final String? useradd = prefs!.getString('user-KELUARGA');
    if (useradd == null) return;

    final List<dynamic> listUserAdd = json.decode(useradd);
    for (var el in listUserAdd) {
      Map<String, String> map = el.cast<String, String>();
      userAdd.add(map);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
