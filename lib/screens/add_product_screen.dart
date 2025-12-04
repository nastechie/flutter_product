import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Uint8List? _imageBytes;
  String? _imageName;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageName = picked.name;
      });
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imageBytes == null) {
      EasyLoading.showError("Please select an image");
      return;
    }

    EasyLoading.show(status: "Saving...");

    // Step 1: Upload image
    final uploadResponse = await ApiService.multipartRequest(
      endpoint: "http://127.0.0.1/midterm_project/api/upload_image.php",
      fields: {"folder": "uploads"},
      fileField: "product_image",
      fileBytes: _imageBytes!,
      fileName: _imageName!,
    );

    if (uploadResponse["status"] != "success") {
      EasyLoading.showError("Image upload failed!");
      return;
    }

    String uploadedFileName = uploadResponse["file_name"];

    // Step 2: Insert product
    Product product = Product(
      productName: nameController.text.trim(),
      category: categoryController.text.trim(),
      description: descriptionController.text.trim(),
      qty: int.tryParse(qtyController.text) ?? 0,
      unitPrice: double.tryParse(priceController.text) ?? 0,
      productImage: uploadedFileName,
      status: "active",
    );

    final insertResponse = await ApiService.postRequest(
      endpoint: "http://127.0.0.1/midterm_project/api/insert_product.php",
      data: product.toJson(),
    );

    EasyLoading.dismiss();

    if (insertResponse["status"] == "success") {
      EasyLoading.showSuccess("Product added!");
      Navigator.pop(context);
    } else {
      EasyLoading.showError(insertResponse["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ---------- IMAGE PICKER ----------
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: _imageBytes == null
                      ? const Center(
                    child: Text(
                      "Tap to select image",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      _imageBytes!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),

              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              TextFormField(
                controller: qtyController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text("Save Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
