import 'dart:convert';
import 'dart:io';
import 'package:admin_kemiri/constants/api_url.dart';
import 'package:admin_kemiri/models/komoditas_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class KomoditasService {
  final String baseUrl = '$baseApiUrl/potensi-komoditas';

  Future<List<KomoditasModel>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => KomoditasModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data komoditas');
    }
  }

  Future<KomoditasModel> createKomoditas({
    required String judul,
    required String deskripsi,
    required File image,
  }) async {
    final uri = Uri.parse(baseUrl);
    final mimeType = lookupMimeType(image.path)!.split('/');

    final request = http.MultipartRequest('POST', uri)
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return KomoditasModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Gagal tambah data');
    }
  }

  Future<void> updateKomoditas({
    required int id,
    required String judul,
    required String deskripsi,
    File? image,
  }) async {
    final uri = Uri.parse('$baseUrl/$id');

    final request = http.MultipartRequest('PUT', uri)
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi;

    if (image != null) {
      final mimeType = lookupMimeType(image.path)!.split('/');
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Gagal update data');
    }
  }

  Future<void> deleteKomoditas(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Gagal hapus data');
    }
  }
}
