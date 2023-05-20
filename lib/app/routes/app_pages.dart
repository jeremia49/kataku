import 'package:get/get.dart';

import '../modules/aktivitas/bindings/aktivitas_binding.dart';
import '../modules/aktivitas/views/aktivitas_view.dart';
import '../modules/angka/bindings/angka_binding.dart';
import '../modules/angka/views/angka_view.dart';
import '../modules/bagiantubuh/bindings/bagiantubuh_binding.dart';
import '../modules/bagiantubuh/views/bagiantubuh_view.dart';
import '../modules/bentuk/bindings/bentuk_binding.dart';
import '../modules/bentuk/views/bentuk_view.dart';
import '../modules/buah/bindings/buah_binding.dart';
import '../modules/buah/views/buah_view.dart';
import '../modules/hewan/bindings/hewan_binding.dart';
import '../modules/hewan/views/hewan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/huruf/bindings/huruf_binding.dart';
import '../modules/huruf/views/huruf_view.dart';
import '../modules/keluarga/bindings/keluarga_binding.dart';
import '../modules/keluarga/views/keluarga_view.dart';
import '../modules/mainmenu/bindings/mainmenu_binding.dart';
import '../modules/mainmenu/views/mainmenu_view.dart';
import '../modules/pakaian/bindings/pakaian_binding.dart';
import '../modules/pakaian/views/pakaian_view.dart';
import '../modules/panduan/bindings/panduan_binding.dart';
import '../modules/panduan/views/panduan_view.dart';
import '../modules/perasaan/bindings/perasaan_binding.dart';
import '../modules/perasaan/views/perasaan_view.dart';
import '../modules/rumah/bindings/rumah_binding.dart';
import '../modules/rumah/views/rumah_view.dart';
import '../modules/sekolah/bindings/sekolah_binding.dart';
import '../modules/sekolah/views/sekolah_view.dart';
import '../modules/warna/bindings/warna_binding.dart';
import '../modules/warna/views/warna_view.dart';

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
      page: () => MainmenuView(),
      binding: MainmenuBinding(),
    ),
    GetPage(
      name: _Paths.KELUARGA,
      page: () => const KeluargaView(),
      binding: KeluargaBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS,
      page: () => const AktivitasView(),
      binding: AktivitasBinding(),
    ),
    GetPage(
      name: _Paths.BUAH,
      page: () => const BuahView(),
      binding: BuahBinding(),
    ),
    GetPage(
      name: _Paths.HEWAN,
      page: () => const HewanView(),
      binding: HewanBinding(),
    ),
    GetPage(
      name: _Paths.BAGIANTUBUH,
      page: () => const BagiantubuhView(),
      binding: BagiantubuhBinding(),
    ),
    GetPage(
      name: _Paths.WARNA,
      page: () => const WarnaView(),
      binding: WarnaBinding(),
    ),
    GetPage(
      name: _Paths.BENTUK,
      page: () => const BentukView(),
      binding: BentukBinding(),
    ),
    GetPage(
      name: _Paths.PAKAIAN,
      page: () => const PakaianView(),
      binding: PakaianBinding(),
    ),
    GetPage(
      name: _Paths.RUMAH,
      page: () => const RumahView(),
      binding: RumahBinding(),
    ),
    GetPage(
      name: _Paths.SEKOLAH,
      page: () => const SekolahView(),
      binding: SekolahBinding(),
    ),
    GetPage(
      name: _Paths.ANGKA,
      page: () => const AngkaView(),
      binding: AngkaBinding(),
    ),
    GetPage(
      name: _Paths.HURUF,
      page: () => const HurufView(),
      binding: HurufBinding(),
    ),
    GetPage(
      name: _Paths.PERASAAN,
      page: () => const PerasaanView(),
      binding: PerasaanBinding(),
    ),
    GetPage(
      name: _Paths.PANDUAN,
      page: () => const PanduanView(),
      binding: PanduanBinding(),
    ),
  ];
}
