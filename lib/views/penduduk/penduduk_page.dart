import 'package:admin_kemiri/controllers/penduduk_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendudukPage extends GetView<PendudukController> {
  const PendudukPage({super.key});

  Widget _numberField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      children: [
        // Tombol -
        _roundIconButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 8),
        // TextField
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Tombol +
        _roundIconButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }

  Widget _roundIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 20, color: Colors.white),
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
      appBar: AppBar(
        title: const Text('Data Penduduk'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.data.value;

        if (data == null) {
          return const Center(child: Text("Data belum tersedia"));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _numberField(
                label: 'Jumlah KK',
                controller: controller.kkController,
                onIncrement:
                    () => _updateTextController(controller.kkController, 1),
                onDecrement:
                    () => _updateTextController(controller.kkController, -1),
              ),
              const SizedBox(height: 16),
              _numberField(
                label: 'Jumlah Laki-laki',
                controller: controller.lakiController,
                onIncrement:
                    () => _updateTextController(controller.lakiController, 1),
                onDecrement:
                    () => _updateTextController(controller.lakiController, -1),
              ),
              const SizedBox(height: 16),
              _numberField(
                label: 'Jumlah Perempuan',
                controller: controller.perempuanController,
                onIncrement:
                    () => _updateTextController(
                      controller.perempuanController,
                      1,
                    ),
                onDecrement:
                    () => _updateTextController(
                      controller.perempuanController,
                      -1,
                    ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                return ElevatedButton(
                  onPressed:
                      controller.isUpdateLoading.value
                          ? null
                          : () {
                            Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText:
                                  "Apakah kamu yakin ingin memperbarui data penduduk?",
                              textCancel: "Batal",
                              textConfirm: "Ya, Update",
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.green,
                              onConfirm: () async  {
                                Get.back(); 
                                await controller.updateData(); 
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
                      controller.isUpdateLoading.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text("Update Data"),
                );
              }),
              const SizedBox(height: 16),
              Text(
                "Total Penduduk: ${data.dataPenduduk}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }),
    );
  }
}
