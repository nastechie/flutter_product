import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a1a23),
      child: ListTile(
        leading: product.imageUrl != null
            ? Image.network(
          product.imageUrl!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        )
            : const Icon(Icons.inventory, color: Colors.white),
        title: Text(
          product.productName,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${product.category} • ${product.formattedPrice}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          'Qty: ${product.qty}',
          style: const TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}