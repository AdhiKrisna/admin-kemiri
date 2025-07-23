import 'package:admin_kemiri/controllers/struktural_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrukturalPage extends GetView<StrukturalController> {
  const StrukturalPage({super.key});

  Widget _modernStructuralCard({
    required String imageUrl,
    required TextEditingController namaController,
    required TextEditingController jabatanController,
    required VoidCallback onPickImage,
    required VoidCallback onUpdate,
    required VoidCallback onDelete,
    required int itemId,
    required String currentName,
    required bool canDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                currentName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: onPickImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Preview gambar baru jika ada
            Obx(() {
              final picked = controller.pickedImages[itemId];
              if (picked != null) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          picked,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.pickedImages.remove(itemId),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Gambar Baru",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }),

            // Form Fields
            _modernTextField(
              controller: namaController,
              label: 'Nama Lengkap',
              icon: Icons.person_outline,
              color: Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 16),
            
            _modernTextField(
              controller: jabatanController,
              label: 'Jabatan',
              icon: Icons.work_outline,
              color: const Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onUpdate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.update, size: 18),
                    label: const Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: canDelete ? onDelete : () {
                      Get.snackbar(
                        "Tidak Diizinkan",
                        "Kepala Desa tidak bisa dihapus!",
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canDelete ? Colors.red[400] : Colors.grey[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text(
                      "Hapus",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2E2E2E),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: color,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D63),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar with Mountain
              Container(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Mountain background
                    Positioned.fill(
                      child: CustomPaint(
                        painter: MountainPainter(),
                      ),
                    ),
                    // Back button
                    Positioned(
                      top: 12,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    // Add button
                    Positioned(
                      top: 12,
                      right: 16,
                      child: GestureDetector(
                        onTap: () => controller.goToAddStruktural(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    // Title
                    const Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            "DATA STRUKTURAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Kelola Struktur Organisasi Desa",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Main Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2E7D63),
                        ),
                      );
                    }

                    if (controller.structurals.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Belum Ada Data Struktural",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tambahkan anggota struktural desa",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => controller.goToAddStruktural(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D63),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text("Tambah Data"),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: controller.fetchData,
                      color: const Color(0xFF2E7D63),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.structurals.length,
                        itemBuilder: (context, index) {
                          final item = controller.structurals[index];
                          final namaCtrl = controller.namaControllers[item.id];
                          final jabatanCtrl = controller.jabatanControllers[item.id];
                          
                          return _modernStructuralCard(
                            imageUrl: item.imageUrl,
                            namaController: namaCtrl!,
                            jabatanController: jabatanCtrl!,
                            onPickImage: () => controller.pickImage(item.id),
                            itemId: item.id,
                            currentName: item.nama,
                            canDelete: item.id != 1,
                            onUpdate: () {
                              Get.defaultDialog(
                                title: "Konfirmasi Update",
                                middleText: "Apakah Anda yakin ingin memperbarui data ${item.nama}?",
                                textCancel: "Batal",
                                textConfirm: "Ya, Update",
                                confirmTextColor: Colors.white,
                                buttonColor: const Color(0xFF2E7D63),
                                cancelTextColor: const Color(0xFF2E7D63),
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
                            onDelete: () {
                              Get.defaultDialog(
                                title: "Konfirmasi Hapus",
                                middleText: "Apakah Anda yakin ingin menghapus data ${item.nama}?",
                                textCancel: "Batal",
                                textConfirm: "Ya, Hapus",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.red[400],
                                cancelTextColor: Colors.red[400],
                                onConfirm: () {
                                  Get.back();
                                  controller.deleteStruktural(item.id);
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Base background gradient
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF1B5E20),
        Color(0xFF2E7D63),
        Color(0xFF4CAF50),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Mountain layers
    paint.shader = null;
    
    // Back mountain
    paint.color = const Color(0xFF1B5E20).withOpacity(0.4);
    Path backMountain = Path();
    backMountain.moveTo(0, size.height);
    backMountain.lineTo(0, size.height * 0.6);
    backMountain.lineTo(size.width * 0.2, size.height * 0.3);
    backMountain.lineTo(size.width * 0.5, size.height * 0.4);
    backMountain.lineTo(size.width * 0.8, size.height * 0.2);
    backMountain.lineTo(size.width, size.height * 0.5);
    backMountain.lineTo(size.width, size.height);
    backMountain.close();
    canvas.drawPath(backMountain, paint);

    // Front mountain
    paint.color = const Color(0xFF1B5E20).withOpacity(0.6);
    Path frontMountain = Path();
    frontMountain.moveTo(0, size.height);
    frontMountain.lineTo(0, size.height * 0.8);
    frontMountain.lineTo(size.width * 0.3, size.height * 0.5);
    frontMountain.lineTo(size.width * 0.6, size.height * 0.6);
    frontMountain.lineTo(size.width, size.height * 0.7);
    frontMountain.lineTo(size.width, size.height);
    frontMountain.close();
    canvas.drawPath(frontMountain, paint);

    // Sun
    paint.color = const Color(0xFFFFB74D);
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      size.width * 0.08,
      paint,
    );

    // Sun glow
    paint.color = const Color(0xFFFFB74D).withOpacity(0.3);
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      size.width * 0.12,
      paint,
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}