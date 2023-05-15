import 'package:get/get.dart';

import '../controllers/huruf_controller.dart';

class HurufBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HurufController>(
      () => HurufController(),
    );
  }
}
