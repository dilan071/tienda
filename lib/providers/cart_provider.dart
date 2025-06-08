import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  CartProvider() {
    _loadCartFromPrefs();
  }

  void addProduct(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    _saveCartToPrefs();
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _saveCartToPrefs();
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      _saveCartToPrefs();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCartToPrefs();
    notifyListeners();
  }

  // ------------------- PERSISTENCIA -------------------

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonCart =
        _items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart_items', jsonCart);
  }

  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonCart = prefs.getStringList('cart_items');
    if (jsonCart != null) {
      _items.clear();
      _items.addAll(
        jsonCart.map((item) => CartItem.fromJson(jsonDecode(item))),
      );
      notifyListeners();
    }
  }
}
