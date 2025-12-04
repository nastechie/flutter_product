import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:midterm_flutter_app/utils/constants.dart';

class ApiService {
  static Future<Map<String, dynamic>> postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse(endpoint);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: json.encode(data),
      );

      return json.decode(response.body);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> getRequest({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse(endpoint);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );

      return json.decode(response.body);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e'
      };
    }
  }

  // Multipart request for file upload
  static Future<Map<String, dynamic>> multipartRequest({
    required String endpoint,
    required Map<String, String> fields,
    required String fileField,
    required List<int> fileBytes,
    required String fileName,
  }) async {
    try {
      final url = Uri.parse(endpoint);

      var request = http.MultipartRequest('POST', url);

      // Add fields
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add file
      request.files.add(
        http.MultipartFile.fromBytes(
          fileField,
          fileBytes,
          filename: fileName,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      return json.decode(responseBody);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Upload error: $e'
      };
    }
  }
}