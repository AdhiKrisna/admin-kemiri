import 'package:admin_kemiri/controllers/wisata_controller.dart';
import 'package:get/get.dart';

class WisataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WisataController());
  }
}
