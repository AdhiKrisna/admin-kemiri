import 'package:admin_kemiri/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Custom App Bar with Mountain Background
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Mountain Silhouette Background
                    Positioned.fill(
                      child: CustomPaint(
                        painter: MountainPainter(),
                      ),
                    ),
                    // Clouds
                    Positioned(
                      top: 20,
                      right: 50,
                      child: _buildCloud(30),
                    ),
                    Positioned(
                      top: 40,
                      left: 80,
                      child: _buildCloud(20),
                    ),
                    Positioned(
                      top: 15,
                      left: 200,
                      child: _buildCloud(25),
                    ),
                    // Sun
                    Positioned(
                      top: 25,
                      right: 120,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // App Title
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const Text(
                            "ADMIN KEMIRI",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Sistem Informasi Desa Digital",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w300,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.dashboard_outlined,
                                color: Color(0xFF2E7D63),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Dashboard Menu",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E2E2E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                            children: [
                              _buildAdvancedMenuCard(
                                title: "Data Penduduk",
                                subtitle: "Kelola informasi warga desa",
                                icon: Icons.people_outline,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                                ),
                                onTap: controller.goToPenduduk,
                              ),
                              _buildAdvancedMenuCard(
                                title: "Struktural Desa",
                                subtitle: "Organisasi pemerintahan",
                                icon: Icons.account_tree_outlined,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
                                ),
                                onTap: controller.goToStruktural,
                              ),
                              _buildAdvancedMenuCard(
                                title: "Potensi Wisata",
                                subtitle: "Destinasi & objek wisata",
                                icon: Icons.landscape_outlined,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                                ),
                                onTap: controller.goToWisata,
                              ),
                              _buildAdvancedMenuCard(
                                title: "Potensi Komoditas",
                                subtitle: "Produk unggulan desa",
                                icon: Icons.eco_outlined,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                                ),
                                onTap: controller.goToKomoditas,
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }

  Widget _buildAdvancedMenuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Decorative circles
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: -10,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    // Mountain layers with different opacities for depth
    
    // Back mountain (lightest)
    paint.color = Colors.black.withOpacity(0.1);
    Path backMountain = Path();
    backMountain.moveTo(0, size.height * 0.7);
    backMountain.lineTo(size.width * 0.3, size.height * 0.4);
    backMountain.lineTo(size.width * 0.7, size.height * 0.5);
    backMountain.lineTo(size.width, size.height * 0.6);
    backMountain.lineTo(size.width, size.height);
    backMountain.lineTo(0, size.height);
    backMountain.close();
    canvas.drawPath(backMountain, paint);

    // Middle mountain
    paint.color = Colors.black.withOpacity(0.15);
    Path middleMountain = Path();
    middleMountain.moveTo(0, size.height * 0.8);
    middleMountain.lineTo(size.width * 0.4, size.height * 0.5);
    middleMountain.lineTo(size.width * 0.8, size.height * 0.6);
    middleMountain.lineTo(size.width, size.height * 0.7);
    middleMountain.lineTo(size.width, size.height);
    middleMountain.lineTo(0, size.height);
    middleMountain.close();
    canvas.drawPath(middleMountain, paint);

    // Front mountain (darkest)
    paint.color = Colors.black.withOpacity(0.2);
    Path frontMountain = Path();
    frontMountain.moveTo(0, size.height * 0.9);
    frontMountain.lineTo(size.width * 0.2, size.height * 0.7);
    frontMountain.lineTo(size.width * 0.5, size.height * 0.6);
    frontMountain.lineTo(size.width * 0.9, size.height * 0.8);
    frontMountain.lineTo(size.width, size.height * 0.85);
    frontMountain.lineTo(size.width, size.height);
    frontMountain.lineTo(0, size.height);
    frontMountain.close();
    canvas.drawPath(frontMountain, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}