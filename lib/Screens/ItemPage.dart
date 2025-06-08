// lib/pages/ItemPage.dart
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/ItemAppBar.dart';
import '../widgets/ItemBottomNavBar.dart';

class ItemPage extends StatefulWidget {
  static const String routeName = '/itemPage'; // Asegúrate de incluir la '/'

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int _quantity = 1;
  bool _isFavorite = false;
  double _rating = 4.0;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _addToCart(Product product) {
    Provider.of<CartProvider>(context, listen: false).addProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Añadido al carrito: \$${product.price} x $_quantity')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Recibe el producto a través de arguments
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: const Color(0xFFEDDCF2),
      appBar: ItemAppBar(
        title: product.title,
        isFavorite: _isFavorite,
        onBackTap: () => Navigator.pop(context),
        onFavoriteTap: _toggleFavorite,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.network(
              product.image,
              height: 300,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) =>
                  const Icon(Icons.broken_image, size: 300),
            ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Color(0xFF4C53A5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => const Icon(
                            Icons.favorite,
                            color: Color(0xFF4C53A5),
                          ),
                          onRatingUpdate: (rating) {
                            setState(() => _rating = rating);
                          },
                        ),
                        Row(
                          children: [
                            _buildQuantityButton(CupertinoIcons.minus, _decreaseQuantity),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                _quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4C53A5),
                                ),
                              ),
                            ),
                            _buildQuantityButton(CupertinoIcons.plus, _increaseQuantity),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Price: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _addToCart(product),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ItemBottomNavBar(
        price: product.price,
        onAddToCart: () => _addToCart(product),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 18, color: const Color(0xFF4C53A5)),
        onPressed: onTap,
      ),
    );
  }
}
