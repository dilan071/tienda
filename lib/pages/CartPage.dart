import 'package:flutter/material.dart';
import 'package:tienda/widgets/CartAppBar.dart';
import 'package:tienda/widgets/CartBottomNavBar.dart';
import 'package:tienda/widgets/CartItemSamples.dart';

/// Modelo interno para cada item del carrito
class CartItem {
  final String id;
  final String title;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  static const String routeName = 'cartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Datos de carrito
  List<CartItem> _cartItems = [];

  // Controlador y estado de cupón
  final couponController = TextEditingController();
  String _couponMessage = '';
  double _discount = 0.0;
  bool _isCouponApplied = false;

  final Map<String, double> validCoupons = {
    'DESCUENTO10': 0.10,
    'DESCUENTO20': 0.20,
  };

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    
    setState(() {
      _cartItems = [
        CartItem(id: 'p1', title: 'Tacones', imagePath: 'images/1.png', price: 55.0, quantity: 2),
        CartItem(id: 'p2', title: 'Reloj clásico', imagePath: 'images/2.png', price: 120.0, quantity: 1),
        CartItem(id: 'p3', title: 'Bolso elegante', imagePath: 'images/3.png', price: 75.0, quantity: 3),
        CartItem(id: 'p3', title: 'Bolso elegante', imagePath: 'images/4.png', price: 67.0, quantity: 3),
        CartItem(id: 'p3', title: 'Bolso de carga', imagePath: 'images/5.png', price: 95.0, quantity: 4),
        CartItem(id: 'p3', title: 'Bolso elegante', imagePath: 'images/6.png', price: 60.0, quantity: 5),
        CartItem(id: 'p3', title: 'Bolso elegante', imagePath: 'images/7.png', price: 30.0, quantity: 2),
        
      ];
    });
  }

  double get _rawTotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  double get totalAmount {
    return _rawTotal;
  }

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _applyCoupon() {
    final couponCode = couponController.text.trim().toUpperCase();
    if (validCoupons.containsKey(couponCode)) {
      setState(() {
        _discount = validCoupons[couponCode]! * totalAmount;
        _couponMessage = '¡Cupón aplicado! Descuento de ${(validCoupons[couponCode]! * 100).toInt()}%';
        _isCouponApplied = true;
      });
    } else {
      setState(() {
        _couponMessage = 'Cupón no válido';
        _isCouponApplied = false;
      });
    }
  }

  void _showCouponDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ingresar código de cupón'),
        content: TextField(
          controller: couponController,
          decoration: InputDecoration(labelText: 'Código del cupón'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _applyCoupon();
              Navigator.of(ctx).pop();
            },
            child: Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  void _checkout() {
    final double finalTotal = _isCouponApplied ? (totalAmount - _discount) : totalAmount;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Checkout'),
        content: Text('Total a pagar: \$${finalTotal.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double finalTotal = _isCouponApplied ? (totalAmount - _discount) : totalAmount;

    return Scaffold(
      appBar: CartAppBar(),
      body: ListView(
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
                  items: _cartItems,
                  onIncrement: _incrementQuantity,
                  onDecrement: _decrementQuantity,
                  onRemove: _removeItem,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF4C53A5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: _showCouponDialog,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Agregar código de cupón',
                          style: TextStyle(
                            color: Color(0xFF4C53A5),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_couponMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _couponMessage,
                      style: TextStyle(
                        color: _isCouponApplied ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Total: \$${finalTotal.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CartBottomNavBar(
        total: finalTotal,
        onCheckout: _checkout,
      ),
    );
  }
}
