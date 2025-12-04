import 'dart:convert';
import 'package:http/http.dart' as http;

class TestService {
  static Future<void> testConnection() async {
    try {
      // Test different URLs
      final urls = [
        'http://localhost/midterm_project/api/test.php',
        'http://127.0.0.1/midterm_project/api/test.php',
        'http://localhost:8000/midterm_project/api/test.php',
      ];

      for (var url in urls) {
        print('Testing: $url');
        try {
          final response = await http.get(Uri.parse(url));
          print('Response from $url: ${response.statusCode} - ${response.body}');
        } catch (e) {
          print('Error for $url: $e');
        }
      }
    } catch (e) {
      print('Test Error: $e');
    }
  }
}