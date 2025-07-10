  import 'dart:convert';
  import 'dart:io';
  import 'package:admin_kemiri/constants/api_url.dart';
  import 'package:http/http.dart' as http;
  import 'package:admin_kemiri/models/struktural_model.dart';
  import 'package:http_parser/http_parser.dart';
  import 'package:mime/mime.dart';

  class StructuralService {
    final String baseUrl = baseApiUrl;

    Future<List<StrukturalModel>> fetchStructurals() async {
      print("Fetching struktural data from $baseUrl/struktural");
      final response = await http.get(Uri.parse('$baseUrl/struktural'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => StrukturalModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load struktural');
      }
    }

    Future<StrukturalModel> createStruktural({
      required String nama,
      required String jabatan,
      required File image,
    }) async {
      final uri = Uri.parse('$baseUrl/struktural');
      final mimeTypeData = lookupMimeType(image.path)!.split('/');

      final request = http.MultipartRequest('POST', uri)
        ..fields['nama'] = nama
        ..fields['jabatan'] = jabatan
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return StrukturalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)['error'] ?? 'Create failed');
      }
    }

    Future<void> updateStruktural({
      required int id,
      required String nama,
      required String jabatan,
      File? image,
    }) async {
      final uri = Uri.parse('$baseUrl/struktural/$id');
      final request = http.MultipartRequest('PUT', uri)
        ..fields['nama'] = nama
        ..fields['jabatan'] = jabatan;

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
        throw Exception(json.decode(response.body)['error'] ?? 'Update failed');
      }
    }

    Future<void> deleteStruktural(int id) async {
      final response = await http.delete(Uri.parse('$baseUrl/struktural/$id'));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error'] ?? 'Delete failed');
      }
    }
  }
