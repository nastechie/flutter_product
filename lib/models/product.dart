class Product {
  int? productId;
  String productName;
  String category;
  String description;
  int qty;
  double unitPrice;
  String productImage;
  String status;
  String? imageUrl;

  Product({
    this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.qty,
    required this.unitPrice,
    required this.productImage,
    required this.status,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] == null
          ? null
          : int.tryParse(json['product_id'].toString()),
      productName: json['product_name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      qty: int.tryParse(json['qty'].toString()) ?? 0,
      unitPrice: double.tryParse(json['unit_price'].toString()) ?? 0.0,
      productImage: json['product_image'] ?? '',
      status: json['status'] ?? '',
      imageUrl: json['image_url'], // <--- correct URL from API
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'product_name': productName,
      'category': category,
      'description': description,
      'qty': qty,
      'unit_price': unitPrice,
      'product_image': productImage,
      'status': status,
    };

    // Only add product_id if it exists
    if (productId != null) {
      data['product_id'] = productId!;
    }

    return data;
  }

  // <--- restored getter so your UI works
  String get formattedPrice => "\$${unitPrice.toStringAsFixed(2)}";
}
