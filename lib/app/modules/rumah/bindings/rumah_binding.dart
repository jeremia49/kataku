import 'package:get/get.dart';

import '../controllers/rumah_controller.dart';

class RumahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RumahController>(
      () => RumahController(),
    );
  }
}
