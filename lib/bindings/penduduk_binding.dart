import 'package:admin_kemiri/controllers/penduduk_controller.dart';
import 'package:get/get.dart';

class PendudukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendudukController>(() => PendudukController());
  }
  
}