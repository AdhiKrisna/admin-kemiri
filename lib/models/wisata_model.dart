class WisataModel {
  final int id;
  final String judul;
  final String deskripsi;
  final String imageUrl;
  final String imagePublicId;

  WisataModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.imageUrl,
    required this.imagePublicId,
  });

  factory WisataModel.fromJson(Map<String, dynamic> json) {
    return WisataModel(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      imageUrl: json['image_url'],
      imagePublicId: json['image_public_id'],
    );
  }
}
