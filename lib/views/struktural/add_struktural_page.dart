import 'package:admin_kemiri/controllers/struktural_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStrukturalPage extends GetView<StrukturalController> {
  const AddStrukturalPage({super.key});

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
                    // Title
                    const Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            "TAMBAH STRUKTURAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Tambahkan Anggota Struktural Baru",
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
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Image Card with Mountain Painter Effect
                            Container(
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
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        width: double.infinity,
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: controller.imageBaruFile.value != null
                                            ? Stack(
                                                children: [
                                                  Image.file(
                                                    controller.imageBaruFile.value!,
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  // Mountain painter gradient overlay
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
                                                              child: Obx(() => Text(
                                                                controller.namaBaruController.text.isNotEmpty
                                                                    ? controller.namaBaruController.text
                                                                    : 'Nama akan muncul di sini',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontStyle: controller.namaBaruController.text.isEmpty 
                                                                      ? FontStyle.italic 
                                                                      : FontStyle.normal,
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                              )),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () => controller.imageBaruFile.value = null,
                                                              child: Container(
                                                                padding: const EdgeInsets.all(6),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red.withOpacity(0.8),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  color: Colors.white,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.image_outlined,
                                                    size: 48,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Pilih Foto',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  ElevatedButton.icon(
                                                    onPressed: controller.pickNewImage,
                                                    icon: const Icon(Icons.camera_alt),
                                                    label: const Text("Pilih Gambar"),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(0xFF4CAF50),
                                                      foregroundColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Form Fields Card
                            Container(
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
                                  children: [
                                    // Name Input
                                    _modernTextField(
                                      controller: controller.namaBaruController,
                                      label: 'Nama Lengkap',
                                      icon: Icons.person_outline,
                                      color: Color(0xFF4CAF50),
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Position Input
                                    _modernTextField(
                                      controller: controller.jabatanBaruController,
                                      label: 'Jabatan',
                                      icon: Icons.work_outline,
                                      color: const Color(0xFF4CAF50),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Action Buttons
                            Container(
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() {
                                        final isLoading = controller.isLoading.value;
                                        
                                        return ElevatedButton.icon(
                                          onPressed: isLoading
                                              ? null
                                              : () async {
                                                  final nama = controller.namaBaruController.text.trim();
                                                  final jabatan = controller.jabatanBaruController.text.trim();
                                                  final image = controller.imageBaruFile.value;

                                                  if (nama.isEmpty || jabatan.isEmpty || image == null) {
                                                    Get.snackbar(
                                                      "Validasi",
                                                      "Semua field wajib diisi, termasuk gambar.",
                                                      backgroundColor: Colors.orange,
                                                      colorText: Colors.white,
                                                      snackPosition: SnackPosition.TOP,
                                                    );
                                                    return;
                                                  }

                                                  await controller.addStruktural(
                                                    nama: nama,
                                                    jabatan: jabatan,
                                                    image: image,
                                                  );
                                                  controller.clearForm();
                                                },
                                          icon: isLoading
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Icon(Icons.save, size: 18),
                                          label: Text(
                                            isLoading ? "Menyimpan..." : "Simpan",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF4CAF50),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 4,
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          controller.clearForm();
                                          Get.back();
                                        },
                                        icon: const Icon(Icons.cancel_outlined, size: 18),
                                        label: const Text(
                                          "Batal",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[400],
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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