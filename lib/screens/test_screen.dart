import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _responseText = 'Click to test...';
  bool _isTesting = false;

  Future<void> _testApi() async {
    setState(() {
      _isTesting = true;
      _responseText = 'Testing...';
    });

    try {
      // Test different URLs
      final urls = [
        'http://localhost/midterm_project/api/get_products.php',
        'http://127.0.0.1/midterm_project/api/get_products.php',
        'http://localhost:8000/api/get_products.php',
        'http://127.0.0.1:8000/api/get_products.php',
      ];

      String result = '';

      for (var url in urls) {
        result += 'Testing: $url\n';
        try {
          final response = await http.get(
            Uri.parse(url),
            headers: {'Accept': 'application/json'},
          ).timeout(const Duration(seconds: 5));

          result += 'Status: ${response.statusCode}\n';
          result += 'Body: ${response.body}\n\n';
        } catch (e) {
          result += 'Error: $e\n\n';
        }
      }

      setState(() {
        _responseText = result;
      });
    } catch (e) {
      setState(() {
        _responseText = 'Test error: $e';
      });
    } finally {
      setState(() {
        _isTesting = false;
      });
    }
  }

  Future<void> _testDatabase() async {
    setState(() {
      _isTesting = true;
      _responseText = 'Testing database...';
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost/midterm_project/api/test_db.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': 'test'}),
      );

      setState(() {
        _responseText = 'Status: ${response.statusCode}\nBody: ${response.body}';
      });
    } catch (e) {
      setState(() {
        _responseText = 'DB Test error: $e';
      });
    } finally {
      setState(() {
        _isTesting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isTesting ? null : _testApi,
              child: const Text('Test API Connection'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isTesting ? null : _testDatabase,
              child: const Text('Test Database'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _responseText,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}