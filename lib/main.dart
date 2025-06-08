// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/CheckoutPage.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/favorites_provider.dart'; // ✅ nuevo provider
import 'Screens/Homepage.dart';
import 'Screens/CartPage.dart';
import 'Screens/ItemPage.dart';
import 'Screens/favorites_page.dart'; 
import 'providers/orders_provider.dart';
import 'Screens/orders_page.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()), 
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cartPage': (context) => CartPage(),
        '/orders': (context) => OrdersPage(),
        'itemPage': (context) => ItemPage(),
        CheckoutPage.routeName: (context) => CheckoutPage(),
        '/favorites': (context) => FavoritesPage(),
      },
    );
  }
} 