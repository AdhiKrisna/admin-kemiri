import 'package:admin_kemiri/controllers/komoditas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class AddKomoditasPage extends GetView<KomoditasController> {
  const AddKomoditasPage({super.key});

  Widget _modernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    int maxLines = 1,
    String? hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
          hintText: hintText,
          labelStyle: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _imagePickerSection() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            if (controller.imageBaruFile.value == null)
              // Image picker button
              GestureDetector(
                onTap: controller.pickNewImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF4CAF50).withOpacity(0.05),
                    border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.2),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Pilih Gambar Komoditas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tap untuk memilih gambar dari galeri",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Selected image preview
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      controller.imageBaruFile.value!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Gambar Terpilih",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Remove button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => controller.imageBaruFile.value = null,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  // Change image button
                  Positioned(
                    top: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: controller.pickNewImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
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
              // Custom App Bar with Agriculture Theme
              Container(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Agriculture background with fields
                    Positioned.fill(
                      child: CustomPaint(
                        painter: AgriculturePainter(),
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
                    // Title
                    const Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            "TAMBAH KOMODITAS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Tambahkan Potensi Komoditas Baru",
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                        
                        const SizedBox(height: 24),
                        
                        // Form Fields
                        _modernTextField(
                          controller: controller.judulBaruController,
                          label: 'Nama Komoditas',
                          icon: Icons.agriculture,
                          color: Color(0xFF4CAF50),
                          hintText: 'Contoh: Padi Organik Kemiri',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _modernTextField(
                          controller: controller.deskripsiBaruController,
                          label: 'Deskripsi Komoditas',
                          icon: Icons.description_outlined,
                          color: const Color(0xFF4CAF50),
                          maxLines: 5,
                          hintText: 'Jelaskan potensi dan keunggulan komoditas...',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Image Section Label
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.image,
                                  color: Color(0xFF4CAF50),
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Gambar Komoditas",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E2E2E),
                                ),
                              ),
                              const Text(
                                " *",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Image Picker Section
                        _imagePickerSection(),
                        
                        const SizedBox(height: 32),
                        
                        // Submit Button
                        Obx(() {
                          final isLoading = controller.isLoading.value;
                          
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2E7D63).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4CAF50),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          "Menambahkan...",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.agriculture, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          "Tambah Komoditas",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        }),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    final judul = controller.judulBaruController.text.trim();
    final deskripsi = controller.deskripsiBaruController.text.trim();
    final image = controller.imageBaruFile.value;

    if (judul.isEmpty || deskripsi.isEmpty || image == null) {
      Get.snackbar(
        "Validasi",
        "Semua field wajib diisi, termasuk gambar.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.defaultDialog(
      title: "Konfirmasi",
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E2E2E),
      ),
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.help_outline,
              color: Color(0xFF4CAF50),
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Yakin ingin menambahkan potensi komoditas baru?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2E2E2E),
            ),
          ),
        ],
      ),
      textCancel: "Batal",
      textConfirm: "Ya, Tambah",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF2E7D63),
      cancelTextColor: const Color(0xFF2E7D63),
      onConfirm: () async {
        Get.back();
        await controller.addKomoditas(
          judul: judul,
          deskripsi: deskripsi,
          image: image,
        );
        controller.clearForm();
      },
    );
  }
}

class AgriculturePainter extends CustomPainter {
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

    // Agriculture scene layers
    paint.shader = null;
    
    // Fields background
    paint.color = const Color(0xFF1B5E20).withOpacity(0.4);
    Path fields = Path();
    fields.moveTo(0, size.height);
    fields.lineTo(0, size.height * 0.65);
    fields.quadraticBezierTo(size.width * 0.25, size.height * 0.55, size.width * 0.5, size.height * 0.6);
    fields.quadraticBezierTo(size.width * 0.75, size.height * 0.65, size.width, size.height * 0.5);
    fields.lineTo(size.width, size.height);
    fields.close();
    canvas.drawPath(fields, paint);

    // Front fields
    paint.color = const Color(0xFF1B5E20).withOpacity(0.6);
    Path frontFields = Path();
    frontFields.moveTo(0, size.height);
    frontFields.lineTo(0, size.height * 0.75);
    frontFields.quadraticBezierTo(size.width * 0.3, size.height * 0.7, size.width * 0.6, size.height * 0.8);
    frontFields.quadraticBezierTo(size.width * 0.8, size.height * 0.85, size.width, size.height * 0.7);
    frontFields.lineTo(size.width, size.height);
    frontFields.close();
    canvas.drawPath(frontFields, paint);

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

    // Clouds
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white.withOpacity(0.3);
    
    // Cloud 1
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.12), size.width * 0.025, paint);
    canvas.drawCircle(Offset(size.width * 0.17, size.height * 0.09), size.width * 0.03, paint);
    canvas.drawCircle(Offset(size.width * 0.19, size.height * 0.12), size.width * 0.025, paint);
    
    // Cloud 2
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.08), size.width * 0.02, paint);
    canvas.drawCircle(Offset(size.width * 0.57, size.height * 0.06), size.width * 0.025, paint);
    canvas.drawCircle(Offset(size.width * 0.59, size.height * 0.08), size.width * 0.02, paint);

    // Agriculture elements - wheat/rice stalks
    paint.color = const Color(0xFFFFD54F).withOpacity(0.4);
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;
    
    // Draw some wheat/rice stalks
    for (int i = 0; i < 6; i++) {
      final x = size.width * 0.1 + (i * size.width * 0.15);
      final baseY = size.height * 0.85;
      final topY = size.height * 0.4;
      
      // Stalk
      canvas.drawLine(
        Offset(x, baseY),
        Offset(x + size.width * 0.02, topY),
        paint,
      );
      
      // Grain head
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x + size.width * 0.02, topY - size.width * 0.01),
        size.width * 0.008,
        paint,
      );
      paint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}