import 'package:get/get.dart';

import '../controllers/pakaian_controller.dart';

class PakaianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PakaianController>(
      () => PakaianController(),
    );
  }
}
