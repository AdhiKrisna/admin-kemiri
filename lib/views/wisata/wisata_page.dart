import 'dart:math' as math;
import 'package:admin_kemiri/controllers/wisata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WisataPage extends GetView<WisataController> {
  const WisataPage({super.key});

  Widget _modernWisataCard({
    required String imageUrl,
    required TextEditingController judulController,
    required TextEditingController deskripsiController,
    required VoidCallback onPickImage,
    required VoidCallback onUpdate,
    required VoidCallback onDelete,
    required int itemId,
    required String currentTitle,
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
            // Image Section with Gradient Overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.landscape,
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
                      height: 80,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    currentTitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      "Potensi Wisata",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: onPickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
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
                          height: 140,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
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
              controller: judulController,
              label: 'Judul Wisata',
              icon: Icons.title,
              color: Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 16),
            
            _modernTextField(
              controller: deskripsiController,
              label: 'Deskripsi',
              icon: Icons.description_outlined,
              color: const Color(0xFF4CAF50),
              maxLines: 3,
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
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
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
    int maxLines = 1,
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
        maxLines: maxLines,
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
              // Custom App Bar with Tourism Theme
              Container(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Tourism background with waves
                    Positioned.fill(
                      child: CustomPaint(
                        painter: TourismPainter(),
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
                        onTap: () => controller.goToAddWisata(),
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
                            "POTENSI WISATA",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Kelola Data Destinasi Wisata Desa",
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

                    if (controller.wisataList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.landscape_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Belum Ada Data Wisata",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tambahkan destinasi wisata menarik",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => controller.goToAddWisata(),
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
                              label: const Text("Tambah Wisata"),
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
                        itemCount: controller.wisataList.length,
                        itemBuilder: (context, index) {
                          final item = controller.wisataList[index];
                          final judulCtrl = controller.judulControllers[item.id];
                          final deskripsiCtrl = controller.deskripsiControllers[item.id];
                          
                          return _modernWisataCard(
                            imageUrl: item.imageUrl,
                            judulController: judulCtrl!,
                            deskripsiController: deskripsiCtrl!,
                            onPickImage: () => controller.pickImage(item.id),
                            itemId: item.id,
                            currentTitle: item.judul,
                            onUpdate: () {
                              Get.defaultDialog(
                                title: "Konfirmasi Update",
                                middleText: "Apakah Anda yakin ingin memperbarui data wisata '${item.judul}'?",
                                textCancel: "Batal",
                                textConfirm: "Ya, Update",
                                confirmTextColor: Colors.white,
                                buttonColor: const Color(0xFF2E7D63),
                                cancelTextColor: const Color(0xFF2E7D63),
                                onConfirm: () {
                                  Get.back();
                                  controller.updateData(item.id);
                                },
                              );
                            },
                            onDelete: () {
                              Get.defaultDialog(
                                title: "Konfirmasi Hapus",
                                middleText: "Apakah Anda yakin ingin menghapus data wisata '${item.judul}'?",
                                textCancel: "Batal",
                                textConfirm: "Ya, Hapus",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.red[400],
                                cancelTextColor: Colors.red[400],
                                onConfirm: () {
                                  Get.back();
                                  controller.deleteData(item.id);
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

class TourismPainter extends CustomPainter {
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

    // Tourism scene layers
    paint.shader = null;
    
    // Hills background
    paint.color = const Color(0xFF1B5E20).withOpacity(0.4);
    Path hills = Path();
    hills.moveTo(0, size.height);
    hills.lineTo(0, size.height * 0.7);
    hills.quadraticBezierTo(size.width * 0.2, size.height * 0.4, size.width * 0.4, size.height * 0.5);
    hills.quadraticBezierTo(size.width * 0.6, size.height * 0.6, size.width * 0.8, size.height * 0.3);
    hills.quadraticBezierTo(size.width * 0.9, size.height * 0.2, size.width, size.height * 0.4);
    hills.lineTo(size.width, size.height);
    hills.close();
    canvas.drawPath(hills, paint);

    // Front hills
    paint.color = const Color(0xFF1B5E20).withOpacity(0.6);
    Path frontHills = Path();
    frontHills.moveTo(0, size.height);
    frontHills.lineTo(0, size.height * 0.8);
    frontHills.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.5, size.height * 0.7);
    frontHills.quadraticBezierTo(size.width * 0.7, size.height * 0.9, size.width, size.height * 0.6);
    frontHills.lineTo(size.width, size.height);
    frontHills.close();
    canvas.drawPath(frontHills, paint);

    // Sun
    paint.color = const Color(0xFFFFB74D);
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      size.width * 0.06,
      paint,
    );

    // Sun rays
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    paint.color = const Color(0xFFFFB74D).withOpacity(0.7);
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (math.pi / 180);
      final startX = size.width * 0.8 + (size.width * 0.08) * math.cos(angle);
      final startY = size.height * 0.2 + (size.width * 0.08) * math.sin(angle);
      final endX = size.width * 0.8 + (size.width * 0.12) * math.cos(angle);
      final endY = size.height * 0.2 + (size.width * 0.12) * math.sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }

    // Trees
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFF1B5E20).withOpacity(0.8);

    // Clouds
    paint.color = Colors.white.withOpacity(0.3);
    
    // Cloud 1
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.15), size.width * 0.025, paint);
    canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.12), size.width * 0.03, paint);
    canvas.drawCircle(Offset(size.width * 0.24, size.height * 0.15), size.width * 0.025, paint);
    
    // Cloud 2
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.1), size.width * 0.02, paint);
    canvas.drawCircle(Offset(size.width * 0.62, size.height * 0.08), size.width * 0.025, paint);
    canvas.drawCircle(Offset(size.width * 0.64, size.height * 0.1), size.width * 0.02, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}