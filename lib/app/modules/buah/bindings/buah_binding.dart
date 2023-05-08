import 'package:get/get.dart';

import '../controllers/buah_controller.dart';

class BuahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuahController>(
      () => BuahController(),
    );
  }
}
