import 'package:admin_kemiri/models/penduduk_model.dart';
import 'package:admin_kemiri/services/penduduk_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendudukController extends GetxController {
  final service = PendudukService();

  final data = Rx<PendudukModel?>(null);
  final isLoading = false.obs;
  final isUpdateLoading = false.obs;

  final kkController = TextEditingController();
  final lakiController = TextEditingController();
  final perempuanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void incrementKK() {
    final current = int.tryParse(kkController.text) ?? 0;
    kkController.text = (current + 1).toString();
  }

  void decrementKK() {
    final current = int.tryParse(kkController.text) ?? 0;
    if (current > 0) {
      kkController.text = (current - 1).toString();
    }
  }

  void incrementLaki() {
    final current = int.tryParse(lakiController.text) ?? 0;
    lakiController.text = (current + 1).toString();
  }

  void decrementLaki() {
    final current = int.tryParse(lakiController.text) ?? 0;
    if (current > 0) {
      lakiController.text = (current - 1).toString();
    }
  }

  void incrementPerempuan() {
    final current = int.tryParse(perempuanController.text) ?? 0;
    perempuanController.text = (current + 1).toString();
  }

  void decrementPerempuan() {
    final current = int.tryParse(perempuanController.text) ?? 0;
    if (current > 0) {
      perempuanController.text = (current - 1).toString();
    }
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      final result = await service.fetchData();
      data.value = result;

      kkController.text = result.jumlahKk.toString();
      lakiController.text = result.jumlahLaki.toString();
      perempuanController.text = result.jumlahPerempuan.toString();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateData() async {
    final kk = int.tryParse(kkController.text.trim());
    final laki = int.tryParse(lakiController.text.trim());
    final perempuan = int.tryParse(perempuanController.text.trim());

    if (kk == null || laki == null || perempuan == null) {
      Get.snackbar(
        "Validasi",
        "Semua field harus diisi dengan benar",
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isUpdateLoading.value = true;
      await service.updateData(
        jumlahKk: kk,
        jumlahLaki: laki,
        jumlahPerempuan: perempuan,
      );
      fetchData(); // Refresh data

      Get.snackbar(
        "Sukses",
        "Data berhasil diperbarui",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      isUpdateLoading.value = false;
    }
  }

  @override
  void onClose() {
    kkController.dispose();
    lakiController.dispose();
    perempuanController.dispose();
    super.onClose();
  }
}
