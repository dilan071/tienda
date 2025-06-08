import 'package:flutter/foundation.dart';  
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    final isAlreadyFav = _favorites.any((item) => item.id == product.id);
    if (isAlreadyFav) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();  
  }

  bool isFavorite(Product product) {
    return _favorites.any((item) => item.id == product.id);
  }
}
