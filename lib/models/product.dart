class Product {
  int? productId;
  String productName;
  String category;
  String description;
  int qty;
  double unitPrice;
  String productImage;
  String status;

  Product({
    this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.qty,
    required this.unitPrice,
    required this.productImage,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      qty: json['qty'] is int ? json['qty'] : int.tryParse(json['qty'].toString()) ?? 0,
      unitPrice: json['unit_price'] is double
          ? json['unit_price']
          : double.tryParse(json['unit_price'].toString()) ?? 0.0,
      productImage: json['product_image'] ?? '',
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (productId != null && productId! > 0) 'product_id': productId,
      'product_name': productName,
      'category': category,
      'description': description,
      'qty': qty,
      'unit_price': unitPrice,
      'product_image': productImage,
      'status': status,
    };
  }

  // Add missing getters
  String? get imageUrl {
    if (productImage.isNotEmpty) {
      return 'http://localhost/midterm_project/uploads/$productImage';
    }
    return null;
  }

  String get formattedPrice => '\$${unitPrice.toStringAsFixed(2)}';

  bool get isActive => status == 'active';
}