import 'package:admin_kemiri/bindings/home_binding.dart';
import 'package:admin_kemiri/bindings/komoditas_binding.dart';
import 'package:admin_kemiri/bindings/penduduk_binding.dart';
import 'package:admin_kemiri/bindings/struktural_binding.dart';
import 'package:admin_kemiri/bindings/wisata_binding.dart';
import 'package:admin_kemiri/views/home_page.dart';
import 'package:admin_kemiri/routes/route_names.dart';
import 'package:admin_kemiri/views/komoditas/add_komoditas_page.dart';
import 'package:admin_kemiri/views/komoditas/komoditas_page.dart';
import 'package:admin_kemiri/views/penduduk/penduduk_page.dart';
import 'package:admin_kemiri/views/struktural/add_struktural_page.dart';
import 'package:admin_kemiri/views/struktural/struktural_page.dart';
import 'package:admin_kemiri/views/wisata/add_wisata_page.dart';
import 'package:admin_kemiri/views/wisata/wisata_page.dart';
import 'package:get/get.dart';

class RoutePages {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.struktural,
      page: () => const StrukturalPage(),
      binding: StrukturalBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.addStruktural,
      page: () => const AddStrukturalPage(), // Replace with actual PendudukPage
      binding: StrukturalBinding(), // Replace with actual PendudukBinding
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.penduduk,
      page: () => const PendudukPage(),
      transition: Transition.fadeIn,
      binding: PendudukBinding(),
    ),
     GetPage(
      name: RouteNames.wisata,
      page: () => const WisataPage(), // Replace with actual WisataPage
      binding: WisataBinding(), // Replace with actual WisataBinding
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.addWisata,
      page: () => const AddWisataPage(), 
      binding: WisataBinding(), // Replace with actual PendudukBinding
      transition: Transition.fadeIn,
    ),
     GetPage(
      name: RouteNames.komoditas,
      page: () => const KomoditasPage(), // Replace with actual WisataPage
      binding: KomoditasBinding(), // Replace with actual WisataBinding
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.addKomoditas,
      page: () => const AddKomoditasPage(), 
      binding: KomoditasBinding(), // Replace with actual PendudukBinding
      transition: Transition.fadeIn,
    ),
  ];
}
