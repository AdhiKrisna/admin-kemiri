import 'package:admin_kemiri/controllers/komoditas_controller.dart';
import 'package:get/get.dart';

class KomoditasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KomoditasController());
  }
}
