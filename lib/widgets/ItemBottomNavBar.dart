import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomNavBar extends StatelessWidget {
  final double price; // Precio del producto
  final VoidCallback onAddToCart; // Callback para agregar al carrito

  const ItemBottomNavBar({
    Key? key,
    required this.price,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Muestra el precio del producto con formato
            Text(
              '\$${price.toStringAsFixed(2)}', // Formatea el precio con dos decimales
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5), // Color del precio
              ),
            ),
            // Botón para añadir al carrito
            ElevatedButton.icon(
              onPressed: onAddToCart, // Llama al callback cuando se presiona
              icon: Icon(CupertinoIcons.cart_badge_plus), // Icono de carrito
              label: Text(
                "Add to cart", // Texto del botón
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)), // Color de fondo
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 13, horizontal: 15), // Padding interno
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Bordes redondeados
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
