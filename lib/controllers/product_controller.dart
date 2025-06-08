// lib/controllers/product_controller.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductController with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://fakestoreapi.com/products/category/$category');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _products = data.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage = 'Error al obtener productos (Código ${response.statusCode})';
        _products = [];
      }
    } catch (e) {
      _errorMessage = 'Error al conectarse al servidor';
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
