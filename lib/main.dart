// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/CheckoutPage.dart';
import 'Screens/Homepage.dart';
import 'Screens/CartPage.dart';
import 'Screens/ItemPage.dart';
import 'Screens/favorites_page.dart';
import 'Screens/orders_page.dart';

import 'controllers/product_controller.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/orders_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:tienda/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cartPage': (context) => CartPage(),
        '/favorites': (context) => FavoritesPage(),
        '/orders': (context) => OrdersPage(),
        '/itemPage': (context) => ItemPage(),
        '/login': (context) => LoginScreen(),
        CheckoutPage.routeName: (context) => CheckoutPage(),
      },
    );
  }
}
