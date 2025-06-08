// lib/models/order.dart
class Order {
  final String id;
  final String productName;
  final int quantity;
  final double price;
  final DateTime date;
  final String imageUrl;

  Order({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.date,
    required this.imageUrl,
  });
}
