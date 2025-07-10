class PendudukModel {
  final int id;
  final int jumlahKk;
  final int jumlahLaki;
  final int jumlahPerempuan;
  final int dataPenduduk;

  PendudukModel({
    required this.id,
    required this.jumlahKk,
    required this.jumlahLaki,
    required this.jumlahPerempuan,
    required this.dataPenduduk,
  });

  factory PendudukModel.fromJson(Map<String, dynamic> json) {
    return PendudukModel(
      id: json['id'],
      jumlahKk: json['jumlah_kk'],
      jumlahLaki: json['jumlah_laki'],
      jumlahPerempuan: json['jumlah_perempuan'],
      dataPenduduk: json['data_penduduk'],
    );
  }
}
