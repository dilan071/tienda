// lib/widgets/CartItemSamples.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemSamples extends StatelessWidget {
  final List<CartItem> items;
  final void Function(int index) onIncrement;
  final void Function(int index) onDecrement;
  final void Function(int index) onRemove;

  const CartItemSamples({
    Key? key,
    required this.items,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        final item = items[i];
        return Container(
          height: 110,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.network(
                item.product.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) => Icon(Icons.broken_image),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.product.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    Text(
                      '\\${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onRemove(i),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.minus),
                        onPressed: () => onDecrement(i),
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(CupertinoIcons.plus),
                        onPressed: () => onIncrement(i),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
