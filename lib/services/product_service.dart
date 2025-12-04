import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  // Use 127.0.0.1 for Flutter Web. If you later run on Android emulator use 10.0.2.2,
  // or use your LAN IP (http://192.168.x.x) for real devices.
  static const String baseUrl = 'http://127.0.0.1/midterm_project/api';

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_products.php'));

      // Debug: print the body so you can see the API response in console
      // (remove in production).
      print('getProducts response: ${response.statusCode} -> ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          final List<Product> products = [];
          final items = data['data'] as List<dynamic>? ?? [];

          for (var item in items) {
            products.add(Product.fromJson(Map<String, dynamic>.from(item)));
          }

          return products;
        }
      }

      return [];
    } catch (e) {
      print('ProductService.getProducts error: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> insertProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/insert_product.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      return json.decode(response.body);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> deleteProduct(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_product.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'product_id': id}),
      );

      return json.decode(response.body);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e'
      };
    }
  }
}
