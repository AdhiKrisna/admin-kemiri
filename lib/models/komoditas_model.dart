class KomoditasModel {
  final int id;
  final String judul;
  final String deskripsi;
  final String imageUrl;
  final String imagePublicId;
  final DateTime createdAt;
  final DateTime updatedAt;

  KomoditasModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.imageUrl,
    required this.imagePublicId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KomoditasModel.fromJson(Map<String, dynamic> json) {
    return KomoditasModel(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      imageUrl: json['image_url'],
      imagePublicId: json['image_public_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'image_url': imageUrl,
      'image_public_id': imagePublicId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
