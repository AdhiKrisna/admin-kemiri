import 'package:admin_kemiri/controllers/penduduk_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendudukPage extends GetView<PendudukController> {
  const PendudukPage({super.key});

  Widget _modernNumberField({
    required String label,
    required String subtitle,
    required TextEditingController controller,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2E2E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _modernButton(
                  icon: Icons.remove,
                  onTap: onDecrement,
                  color: Colors.red[400]!,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 40,
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
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E2E),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _modernButton(
                  icon: Icons.add,
                  onTap: onIncrement,
                  color: Colors.green[400]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  void _updateTextController(TextEditingController controller, int delta) {
    final current = int.tryParse(controller.text) ?? 0;
    final next = (current + delta).clamp(0, 999999);
    controller.text = next.toString();
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
              // Custom App Bar with Mountain - Made thinner
              Container(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Simple mountain silhouette
                    Positioned.fill(
                      child: CustomPaint(
                        painter: SimpleMountainPainter(),
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
                            "DATA PENDUDUK",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Kelola Informasi Warga Desa",
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

                    final data = controller.data.value;

                    if (data == null) {
                      return const Center(
                        child: Text(
                          "Data belum tersedia",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          
                          // Statistics Card - Made thinner
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2E7D63), Color(0xFF4CAF50)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2E7D63).withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.groups,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Total Penduduk",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${data.dataPenduduk}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "Jiwa",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Input Fields - Made thinner
                          Expanded(
                            child: Column(
                              children: [
                                _modernNumberField(
                                  label: 'Jumlah KK',
                                  subtitle: 'Kepala Keluarga',
                                  controller: controller.kkController,
                                  onIncrement: () => _updateTextController(controller.kkController, 1),
                                  onDecrement: () => _updateTextController(controller.kkController, -1),
                                  icon: Icons.home_outlined,
                                  color: const Color(0xFF2196F3),
                                ),
                                
                                _modernNumberField(
                                  label: 'Jumlah Laki-laki',
                                  subtitle: 'Penduduk pria',
                                  controller: controller.lakiController,
                                  onIncrement: () => _updateTextController(controller.lakiController, 1),
                                  onDecrement: () => _updateTextController(controller.lakiController, -1),
                                  icon: Icons.man,
                                  color: const Color(0xFF4CAF50),
                                ),
                                
                                _modernNumberField(
                                  label: 'Jumlah Perempuan',
                                  subtitle: 'Penduduk wanita',
                                  controller: controller.perempuanController,
                                  onIncrement: () => _updateTextController(controller.perempuanController, 1),
                                  onDecrement: () => _updateTextController(controller.perempuanController, -1),
                                  icon: Icons.woman,
                                  color: const Color(0xFFE91E63),
                                ),
                              ],
                            ),
                          ),
                          
                          // Update Button - Made thinner
                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.isUpdateLoading.value
                                    ? null
                                    : () {
                                        Get.defaultDialog(
                                          title: "Konfirmasi Update",
                                          middleText: "Apakah Anda yakin ingin memperbarui data penduduk?",
                                          textCancel: "Batal",
                                          textConfirm: "Ya, Update",
                                          confirmTextColor: Colors.white,
                                          buttonColor: const Color(0xFF2E7D63),
                                          cancelTextColor: const Color(0xFF2E7D63),
                                          onConfirm: () async {
                                            Get.back();
                                            await controller.updateData();
                                          },
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D63),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 6,
                                  shadowColor: const Color(0xFF2E7D63).withOpacity(0.25),
                                ),
                                child: controller.isUpdateLoading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.update, size: 18),
                                          SizedBox(width: 6),
                                          Text(
                                            "Update Data",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            );
                          }),
                          
                          const SizedBox(height: 16),
                        ],
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

class SimpleMountainPainter extends CustomPainter {
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