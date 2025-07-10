import 'package:admin_kemiri/controllers/wisata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WisataPage extends GetView<WisataController> {
  const WisataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Data Potensi Wisata'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.goToAddWisata();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.wisataList.isEmpty) {
          return const Center(child: Text('Data kosong.'));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchData,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.wisataList.length,
            itemBuilder: (context, index) {
              final item = controller.wisataList[index];
              final judulCtrl = controller.judulControllers[item.id];
              final deskripsiCtrl = controller.deskripsiControllers[item.id];
          
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
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
                        controller: judulCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Judul',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: deskripsiCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton.icon(
                          onPressed: () => controller.pickImage(item.id),
                          icon: const Icon(Icons.image),
                          label: const Text("Ganti Gambar"),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final picked = controller.pickedImages[item.id];
                        if (picked != null) {
                          return Stack(
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
                                child: CircleAvatar(
                                  backgroundColor: Colors.black54,
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
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
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
                                middleText: "Update data '${item.judul}'?",
                                textConfirm: "Ya",
                                textCancel: "Batal",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  controller.updateData(item.id);
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
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Konfirmasi",
                                middleText: "Hapus data '${item.judul}'?",
                                textConfirm: "Ya",
                                textCancel: "Batal",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  controller.deleteData(item.id);
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
