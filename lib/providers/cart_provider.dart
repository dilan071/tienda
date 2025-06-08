import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  // Lista privada de items en el carrito (de tipo CartItem)
  final List<CartItem> _items = [];

  // Lista pública de items, de solo lectura para fuera del provider
  List<CartItem> get items => List.unmodifiable(_items);

  // Obtener el monto total del carrito sumando el total de cada item
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Agregar un producto al carrito
  void addProduct(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // Si el producto ya está en el carrito, aumentar cantidad
      _items[index].quantity++;
    } else {
      // Si no está, agregar nuevo CartItem con cantidad 1
      _items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  // Remover un producto del carrito por ID
  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Disminuir la cantidad de un producto en el carrito
  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Vaciar completamente el carrito
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}