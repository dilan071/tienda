// lib/controllers/order_controller.dart
import '../models/order.dart';

class OrderController {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order); // Inserta al inicio
  }

  void clearOrders() {
    _orders.clear();
  }
}
