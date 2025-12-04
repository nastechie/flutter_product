import 'package:flutter/material.dart';

class AppConstants {
  // API Endpoints
  static const String baseUrl = 'http://localhost/midterm_project';
  // For web: use localhost
  // For Android emulator: 'http://10.0.2.2/midterm_project'

  static const String apiUrl = '$baseUrl/api';

  // API endpoints
  static const String getProductsEndpoint = '$apiUrl/get_products.php';
  static const String getProductEndpoint = '$apiUrl/get_product.php';
  static const String insertProductEndpoint = '$apiUrl/insert_product.php';
  static const String updateProductEndpoint = '$apiUrl/update_product.php';
  static const String deleteProductEndpoint = '$apiUrl/delete_product.php';

  // Colors
  static const Color primaryColor = Color(0xFF9FEF00);
  static const Color backgroundColor = Color(0xFF0f0f14);
  static const Color cardColor = Color(0xFF1a1a23);
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFA0A0B0);

  // App constants
  static const String appName = 'Product Manager';
  static const String appVersion = '1.0.0';

  // SharedPreferences keys
  static const String prefApiUrl = 'api_url';
  static const String prefDarkMode = 'dark_mode';

  // Validation messages
  static const String requiredField = 'This field is required';
  static const String invalidNumber = 'Please enter a valid number';
  static const String invalidPrice = 'Please enter a valid price';
}