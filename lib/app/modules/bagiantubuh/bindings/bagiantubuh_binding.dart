import 'package:get/get.dart';

import '../controllers/bagiantubuh_controller.dart';

class BagiantubuhBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BagiantubuhController>(
      () => BagiantubuhController(),
    );
  }
}
