import 'package:get/get.dart';

import '../controllers/warna_controller.dart';

class WarnaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WarnaController>(
      () => WarnaController(),
    );
  }
}
