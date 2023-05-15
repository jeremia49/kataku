import 'package:get/get.dart';

import '../controllers/perasaan_controller.dart';

class PerasaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerasaanController>(
      () => PerasaanController(),
    );
  }
}
