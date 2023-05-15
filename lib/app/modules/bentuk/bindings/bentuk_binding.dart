import 'package:get/get.dart';

import '../controllers/bentuk_controller.dart';

class BentukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BentukController>(
      () => BentukController(),
    );
  }
}
