import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'http://localhost/midterm_project/api';

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_products.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          List<Product> products = [];
          for (var item in data['data']) {
            products.add(Product.fromJson(item));
          }
          return products;
        }
      }
      return [];
    } catch (e) {
      print('Error: $e');
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