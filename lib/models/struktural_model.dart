class StrukturalModel {
  final int id;
  final String jabatan;
  final String nama;
  final String imageUrl;
  final int role;

  StrukturalModel({
    required this.id,
    required this.jabatan,
    required this.nama,
    required this.imageUrl,
    required this.role,
  });

  factory StrukturalModel.fromJson(Map<String, dynamic> json) {
    return StrukturalModel(
      id: json['id'],
      jabatan: json['jabatan'],
      nama: json['nama'],
      imageUrl: json['image_url'],
      role: json['role'],
    );
  }
}
