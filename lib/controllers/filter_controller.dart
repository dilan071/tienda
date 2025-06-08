// lib/controllers/filter_controller.dart
import '../models/product.dart';

class FilterController {
  static List<Product> filterProducts({
    required List<Product> products,
    required String searchQuery,
    required double? minPrice,
    required double? maxPrice,
  }) {
    return products.where((product) {
      final title = product.title.toLowerCase();
      final matchesSearch = searchQuery.isEmpty || title.contains(searchQuery.toLowerCase());
      final matchesMinPrice = minPrice == null || product.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || product.price <= maxPrice;
      return matchesSearch && matchesMinPrice && matchesMaxPrice;
    }).toList();
  }
}