import 'package:admin_kemiri/controllers/struktural_controller.dart';
import 'package:get/get.dart';

class StrukturalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StrukturalController());
  }
}