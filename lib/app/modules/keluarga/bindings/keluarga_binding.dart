import 'package:get/get.dart';

import '../controllers/keluarga_controller.dart';

class KeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeluargaController>(
      () => KeluargaController(),
    );
  }
}
