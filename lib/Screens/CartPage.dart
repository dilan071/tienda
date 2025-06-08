// lib/pages/CartPage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/cart_provider.dart';
import '../models/cart_item.dart' as ci;
import '../widgets/CartAppBar.dart';
import '../widgets/CartItemSamples.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart'; 

class CartPage extends StatefulWidget {
  static const String routeName = 'cartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;

  double _rawTotal(List<ci.CartItem> items) =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  Future<void> _onCheckoutPressed() async {
    final cart = context.read<CartProvider>();
    final orders = context.read<OrderProvider>();
    final items = cart.items;

    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Estás seguro con esta compra?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2)); 

      final now = DateTime.now();
      final uuid = Uuid();

      // Guardar cada ítem del carrito como una orden
      for (var item in items) {
        final order = Order(
          id: uuid.v4(), 
          productName: item.product.title,
          price: item.totalPrice,
          quantity: item.quantity,
          imageUrl: item.product.image, 
          date: now,
        );
        orders.addOrder(order);
      }

      cart.clearCart();

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra confirmada. ¡Gracias!')),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final List<ci.CartItem> items = cart.items;
    final rawTotal = _rawTotal(items);

    return Scaffold(
      appBar: CartAppBar(),
      body: items.isEmpty
          ? Center(
              child: Text(
                'Tu carrito está vacío.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffedecf2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      CartItemSamples(
                        items: items,
                        onIncrement: (i) => cart.addProduct(items[i].product),
                        onDecrement: (i) =>
                            cart.decreaseQuantity(items[i].product.id),
                        onRemove: (i) => cart.removeProduct(items[i].product.id),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Total: \$${rawTotal.toStringAsFixed(2)}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4C53A5),
                ),
              )
            : ElevatedButton(
                onPressed: _onCheckoutPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C53A5),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  'Check Out',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
      ),
    );
  }
}
