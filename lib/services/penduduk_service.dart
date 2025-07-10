import 'dart:convert';
import 'package:admin_kemiri/constants/api_url.dart';
import 'package:admin_kemiri/models/penduduk_model.dart';
import 'package:http/http.dart' as http;

class PendudukService {
  final baseUrl = baseApiUrl;

  Future<PendudukModel> fetchData() async {
    final res = await http.get(Uri.parse("$baseUrl/penduduk"));
    if (res.statusCode == 200) {
      return PendudukModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Gagal memuat data penduduk");
    }
  }

  Future<void> updateData({
    required int jumlahKk,
    required int jumlahLaki,
    required int jumlahPerempuan,
  }) async {
    final res = await http.put(
      Uri.parse("$baseUrl/penduduk"),
      headers: { "Content-Type": "application/json" },
      body: jsonEncode({
        "jumlah_kk": jumlahKk,
        "jumlah_laki": jumlahLaki,
        "jumlah_perempuan": jumlahPerempuan,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Gagal update data penduduk");
    }
  }
}
