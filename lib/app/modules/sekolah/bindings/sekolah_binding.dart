import 'package:get/get.dart';

import '../controllers/sekolah_controller.dart';

class SekolahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SekolahController>(
      () => SekolahController(),
    );
  }
}
