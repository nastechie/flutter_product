import 'package:flutter/material.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Manager'),
      ),
      body: const ProductListScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9FEF00),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/add-product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}