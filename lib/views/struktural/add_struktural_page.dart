import 'package:admin_kemiri/controllers/struktural_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStrukturalPage extends GetView<StrukturalController> {
  const AddStrukturalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Struktural'),
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
                  controller: controller.namaBaruController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.jabatanBaruController,
                  decoration: const InputDecoration(
                    labelText: 'Jabatan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: controller.pickNewImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Pilih Gambar"),
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
                              final nama =
                                  controller.namaBaruController.text.trim();
                              final jabatan =
                                  controller.jabatanBaruController.text.trim();
                              final image = controller.imageBaruFile.value;

                              if (nama.isEmpty ||
                                  jabatan.isEmpty ||
                                  image == null) {
                                Get.snackbar(
                                  "Validasi",
                                  "Semua field wajib diisi, termasuk gambar.",
                                  backgroundColor: Colors.orange,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              await controller.addStruktural(
                                nama: nama,
                                jabatan: jabatan,
                                image: image,
                              );
                              controller.clearForm(); // reset
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
                            : const Text("Tambah Struktural"),
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
