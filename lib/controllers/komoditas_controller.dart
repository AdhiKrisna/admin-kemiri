import 'dart:io';
import 'package:admin_kemiri/models/komoditas_model.dart';
import 'package:admin_kemiri/routes/route_names.dart';
import 'package:admin_kemiri/services/komoditas_service.dart';
import 'package:admin_kemiri/views/komoditas/add_komoditas_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class KomoditasController extends GetxController {
  final service = KomoditasService();

  var komoditasList = <KomoditasModel>[].obs;
  var isLoading = false.obs;

  final judulControllers = <int, TextEditingController>{};
  final deskripsiControllers = <int, TextEditingController>{};
  final pickedImages = <int, File?>{}.obs;

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
      komoditasList.assignAll(data);

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
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImages[id] = File(picked.path);
      update();
    }
  }

  Future<void> pickNewImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageBaruFile.value = File(picked.path);
    }
  }

  Future<void> updateData(int id) async {
    try {
      isLoading.value = true;
      await service.updateKomoditas(
        id: id,
        judul: judulControllers[id]?.text ?? '',
        deskripsi: deskripsiControllers[id]?.text ?? '',
        image: pickedImages[id],
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
      await service.deleteKomoditas(id);
      komoditasList.removeWhere((e) => e.id == id);
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

  Future<void> addKomoditas({
    required String judul,
    required String deskripsi,
    required File image,
  }) async {
    try {
      isLoading.value = true;
      await service.createKomoditas(
        judul: judul,
        deskripsi: deskripsi,
        image: image,
      );
      Get.back(); 
      Get.snackbar(
        "Sukses",
        "Data berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchData();
      Get.offNamed(RouteNames.komoditas);
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

  void goToAddKomoditas() {
    clearForm();
    Get.to(() => const AddKomoditasPage());
  }
}
