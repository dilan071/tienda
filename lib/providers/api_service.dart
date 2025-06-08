// lib/providers/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  /// Obtiene todos los productos de la API.
  static Future<List<Product>> fetchAllProducts() async {
    final url = Uri.parse('$_baseUrl/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los productos: ${response.statusCode}');
    }
  }

  /// Obtiene los productos de una categoría específica, por ejemplo 'jewelery'.
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    
    final url = Uri.parse('$_baseUrl/products/category/$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar categoría $category: ${response.statusCode}');
    }
  }
}
