import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  static const _prefsKey = 'orders';
  final List<Order> _orders = [];

  OrderProvider() {
    _loadOrders();
  }

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order);
    _saveOrders();
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    _saveOrders();
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _orders.map((o) => json.encode(o.toJson())).toList();
    await prefs.setStringList(_prefsKey, encoded);
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey) ?? [];
    _orders
      ..clear()
      ..addAll(stored.map((j) => Order.fromJson(json.decode(j))));
    notifyListeners();
  }
}
