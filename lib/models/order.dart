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

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'quantity': quantity,
        'price': price,
        'date': date.toIso8601String(),
        'imageUrl': imageUrl,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] as String,
        productName: json['productName'] as String,
        quantity: json['quantity'] as int,
        price: (json['price'] as num).toDouble(),
        date: DateTime.parse(json['date'] as String),
        imageUrl: json['imageUrl'] as String,
      );
}
