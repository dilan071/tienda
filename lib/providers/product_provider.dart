// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Carga todos los productos desde la API
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService.fetchAllProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carga productos filtrados por categoría
  Future<void> fetchByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService.fetchProductsByCategory(category);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Limpia los productos cargados
  void clear() {
    _products = [];
    _errorMessage = null;
    notifyListeners();
  }
}
