import 'dart:io';
import 'package:admin_kemiri/models/wisata_model.dart';
import 'package:admin_kemiri/routes/route_names.dart';
import 'package:admin_kemiri/services/wisata_service.dart';
import 'package:admin_kemiri/views/wisata/add_wisata_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WisataController extends GetxController {
  final service = WisataService();

  var wisataList = <WisataModel>[].obs;
  var isLoading = false.obs;

  final judulControllers = <int, TextEditingController>{};
  final deskripsiControllers = <int, TextEditingController>{};
  final pickedImages = <int, File?>{}.obs;

  // 👉 Untuk add wisata
  final judulBaruController = TextEditingController();
  final deskripsiBaruController = TextEditingController();
  final imageBaruFile = Rxn<File>();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final data = await service.fetchAll();
      wisataList.assignAll(data);

      for (var item in data) {
        judulControllers[item.id] = TextEditingController(text: item.judul);
        deskripsiControllers[item.id] = TextEditingController(
          text: item.deskripsi,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal ambil data: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(int id) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImages[id] = File(picked.path);
      update();
    }
  }

  Future<void> pickNewImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageBaruFile.value = File(picked.path);
    }
  }

  Future<void> updateData(int id) async {
    final judul = judulControllers[id]?.text ?? '';
    final deskripsi = deskripsiControllers[id]?.text ?? '';
    final image = pickedImages[id];

    try {
      isLoading.value = true;
      await service.updateWisata(
        id: id,
        judul: judul,
        deskripsi: deskripsi,
        image: image,
      );

      pickedImages.remove(id);
      Get.snackbar(
        "Sukses",
        "Data berhasil diupdate",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchData();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal update: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deleteData(int id) async {
    try {
      isLoading.value = true;
      await service.deleteWisata(id);
      wisataList.removeWhere((e) => e.id == id);
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
      isLoading.value = false;
    }
  }

  // ✅ ADD WISATA
  Future<void> addWisata({
    required String judul,
    required String deskripsi,
    required File image,
  }) async {
    try {
      isLoading.value = true;
      await service.createWisata(
        judul: judul,
        deskripsi: deskripsi,
        image: image,
      );
      Get.snackbar(
        "Sukses",
        "Data berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchData();
      Get.offNamed(RouteNames.wisata);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal tambah data: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    judulBaruController.clear();
    deskripsiBaruController.clear();
    imageBaruFile.value = null;
  }

  void goToAddWisata() {
    clearForm();
    Get.to(() => const AddWisataPage());
  }
}
