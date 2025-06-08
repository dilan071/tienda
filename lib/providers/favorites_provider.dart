// lib/providers/favorites_provider.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  static const _prefsKey = 'fav_ids';
  final List<String> _favIds = [];

  FavoritesProvider() {
    _loadFavorites();
  }

  /// IDs de productos marcados como favoritos
  List<String> get favIds => List.unmodifiable(_favIds);

  /// Comprueba si un producto ya está en favoritos
  bool isFavorite(String productId) => _favIds.contains(productId);

  /// Añade o quita un producto de favoritos y persiste el cambio
  void toggleFavorite(Product product) {
    if (_favIds.contains(product.id)) {
      _favIds.remove(product.id);
    } else {
      _favIds.add(product.id);
    }
    _saveFavorites();
    notifyListeners();
  }

  /// Guarda la lista de IDs en SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _favIds);
  }

  /// Carga al iniciar desde SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey) ?? [];
    _favIds
      ..clear()
      ..addAll(stored);
    notifyListeners();
  }
}
