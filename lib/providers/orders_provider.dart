// lib/providers/orders_provider.dart
import 'package:flutter/foundation.dart';
import '../controllers/order_controller.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  final OrderController _orderController = OrderController();

  List<Order> get orders => _orderController.orders;

  void addOrder(Order order) {
    _orderController.addOrder(order);
    notifyListeners();
  }

  void clearOrders() {
    _orderController.clearOrders();
    notifyListeners();
  }
}
