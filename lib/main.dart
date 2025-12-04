import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'screens/home_screen.dart';
import 'screens/add_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF0f0f14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0f0f14),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/add-product': (context) => const AddProductScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}