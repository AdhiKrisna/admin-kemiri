// services/wisata_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:admin_kemiri/constants/api_url.dart';
import 'package:admin_kemiri/models/wisata_model.dart';

class WisataService {
  final String baseUrl = "$baseApiUrl/potensi-wisata";

  Future<List<WisataModel>> fetchAll() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => WisataModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal fetch data wisata');
    }
  }

  Future<WisataModel> createWisata({
    required String judul,
    required String deskripsi,
    required File image,
  }) async {
    final uri = Uri.parse(baseUrl);
    final mimeTypeData = lookupMimeType(image.path)!.split('/');

    final request = http.MultipartRequest('POST', uri)
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return WisataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Create failed');
    }
  }

  Future<void> updateWisata({
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
      final mimeTypeData = lookupMimeType(image.path)!.split('/');
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Update failed');
    }
  }

  Future<void> deleteWisata(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['error'] ?? 'Delete failed');
    }
  }
}
