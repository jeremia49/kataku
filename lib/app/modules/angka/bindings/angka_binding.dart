import 'package:get/get.dart';

import '../controllers/angka_controller.dart';

class AngkaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AngkaController>(
      () => AngkaController(),
    );
  }
}
