import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/keluarga/bindings/keluarga_binding.dart';
import '../modules/keluarga/views/keluarga_view.dart';
import '../modules/mainmenu/bindings/mainmenu_binding.dart';
import '../modules/mainmenu/views/mainmenu_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAINMENU,
      page: () => const MainmenuView(),
      binding: MainmenuBinding(),
    ),
    GetPage(
      name: _Paths.KELUARGA,
      page: () => const KeluargaView(),
      binding: KeluargaBinding(),
    ),
  ];
}
