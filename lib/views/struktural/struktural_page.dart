import 'package:admin_kemiri/controllers/struktural_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrukturalPage extends GetView<StrukturalController> {
  const StrukturalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Data Struktural Desa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.goToAddStruktural();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.structurals.isEmpty) {
          return const Center(child: Text('Data kosong.'));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchData,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.structurals.length,
            itemBuilder: (context, index) {
              final item = controller.structurals[index];
              final namaCtrl = controller.namaControllers[item.id];
              final jabatanCtrl = controller.jabatanControllers[item.id];
          
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: namaCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: jabatanCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Jabatan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () => controller.pickImage(item.id),
                        icon: const Icon(Icons.image),
                        label: const Text("Ganti Gambar"),
                      ),
                      const SizedBox(height: 12),
          
                      // ✅ Tampilkan image baru kalau ada
                      Obx(() {
                        final picked = controller.pickedImages[item.id];
                        if (picked != null) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    picked,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed:
                                          () => controller.pickedImages.remove(
                                            item.id,
                                          ),
                                      tooltip: 'Hapus gambar',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox(); // Fallback kalau belum ada image
                      }),
          
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Konfirmasi",
                                middleText: "Update data ${item.nama}?",
                                textConfirm: "Ya",
                                textCancel: "Batal",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  controller.editStruktural(
                                    id: item.id,
                                    nama: namaCtrl?.text ?? '',
                                    jabatan: jabatanCtrl?.text ?? '',
                                    image: controller.pickedImages[item.id],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text("Update"),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed:
                                item.id == 1
                                    ? () {
                                      Get.snackbar(
                                        "Tidak Diizinkan",
                                        "Kepala Desa tidak bisa dihapus!",
                                        backgroundColor: Colors.orange,
                                        colorText: Colors.white,
                                      );
                                    }
                                    : () {
                                      Get.defaultDialog(
                                        title: "Konfirmasi",
                                        middleText: "Hapus data ${item.nama}?",
                                        textConfirm: "Ya",
                                        textCancel: "Batal",
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          Get.back();
                                          controller.deleteStruktural(item.id);
                                        },
                                      );
                                    },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text("Hapus"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
