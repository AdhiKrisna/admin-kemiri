import 'dart:developer';
import 'dart:io';
import 'package:admin_kemiri/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_kemiri/models/struktural_model.dart';
import 'package:admin_kemiri/services/structural_service.dart';
import 'package:image_picker/image_picker.dart';

class StrukturalController extends GetxController {
  var structurals = <StrukturalModel>[].obs;
  var isLoading = false.obs;

  final _service = StructuralService();

  final Map<int, TextEditingController> namaControllers = {};
  final Map<int, TextEditingController> jabatanControllers = {};
  final pickedImages = <int, File?>{}.obs;
  // Tambahan untuk form tambah struktural
  final namaBaruController = TextEditingController();
  final jabatanBaruController = TextEditingController();
  final imageBaruFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void goToAddStruktural() {
    Get.toNamed('/add-struktural');
  }

  void pickNewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBaruFile.value = File(pickedFile.path);
    }
  }

  void clearForm() {
    namaBaruController.clear();
    jabatanBaruController.clear();
    imageBaruFile.value = null;
  }

  Future<void> pickImage(int id) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImages[id] = File(pickedFile.path);
      update(); // Memicu GetBuilder atau GetX rebuild
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final data = await _service.fetchStructurals();
      structurals.assignAll(data);

      for (var item in data) {
        namaControllers[item.id] = TextEditingController(text: item.nama);
        jabatanControllers[item.id] = TextEditingController(text: item.jabatan);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      log('Error fetching data: $e', error: e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addStruktural({
    required String nama,
    required String jabatan,
    required File image,
  }) async {
    try {
      isLoading(true);
      final newData = await _service.createStruktural(
        nama: nama,
        jabatan: jabatan,
        image: image,
      );
      structurals.add(newData);
      namaControllers[newData.id] = TextEditingController(text: newData.nama);
      jabatanControllers[newData.id] = TextEditingController(
        text: newData.jabatan,
      );

      Get.snackbar(
        "Sukses",
        "Data berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offNamed(RouteNames.struktural);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menambahkan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> editStruktural({
    required int id,
    required String nama,
    required String jabatan,
    File? image,
  }) async {
    try {
      isLoading(true);
      await _service.updateStruktural(
        id: id,
        nama: nama,
        jabatan: jabatan,
        image: image,
      );
      fetchData();
      Get.snackbar(
        "Sukses",
        "Data berhasil diupdate",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      //empty the picked image for this id
      pickedImages.remove(id);
      update();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal update: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteStruktural(int id) async {
    try {
      isLoading(true);
      await _service.deleteStruktural(id);
      structurals.removeWhere((item) => item.id == id);
      namaControllers.remove(id)?.dispose();
      jabatanControllers.remove(id)?.dispose();

      Get.snackbar(
        "Sukses",
        "Data berhasil dihapus",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal hapus: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    for (var controller in namaControllers.values) {
      controller.dispose();
    }
    for (var controller in jabatanControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
