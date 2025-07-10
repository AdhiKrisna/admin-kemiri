import 'package:admin_kemiri/controllers/wisata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWisataPage extends GetView<WisataController> {
  const AddWisataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Potensi Wisata"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: controller.judulBaruController,
                  decoration: const InputDecoration(
                    labelText: "Nama Tempat",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.deskripsiBaruController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    onPressed: controller.pickNewImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Pilih Gambar"),
                  ),
                ),
                const SizedBox(height: 12),
                if (controller.imageBaruFile.value != null)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          controller.imageBaruFile.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.imageBaruFile.value = null,
                          child: const CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                Obx(() {
                  final isLoading = controller.isLoading.value;

                  return ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              final judul =
                                  controller.judulBaruController.text.trim();
                              final deskripsi =
                                  controller.deskripsiBaruController.text
                                      .trim();
                              final image = controller.imageBaruFile.value;

                              if (judul.isEmpty ||
                                  deskripsi.isEmpty ||
                                  image == null) {
                                Get.snackbar(
                                  "Validasi",
                                  "Semua field wajib diisi, termasuk gambar.",
                                  backgroundColor: Colors.orange,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              Get.defaultDialog(
                                title: "Konfirmasi",
                                middleText:
                                    "Yakin ingin menambahkan potensi wisata baru?",
                                textCancel: "Batal",
                                textConfirm: "Ya, Tambah",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.green,
                                onConfirm: () async {
                                  Get.back(); // Tutup dialog
                                  await controller.addWisata(
                                    judul: judul,
                                    deskripsi: deskripsi,
                                    image: image,
                                  );
                                  controller.clearForm();
                                },
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                    ),
                    child:
                        isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text("Tambah Wisata"),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
