import 'package:admin_kemiri/routes/route_names.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  void goToPenduduk() {
    Get.toNamed(RouteNames.penduduk);
  }
  void goToStruktural(){
    Get.toNamed(RouteNames.struktural);
  }
  void goToWisata(){
    Get.toNamed(RouteNames.wisata);
  }
  void goToKomoditas(){
    Get.toNamed(RouteNames.komoditas);  
  }
  
}