import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/pages/CartPage.dart';
import 'package:tienda/pages/Homepage.dart';
import 'package:tienda/pages/ItemPage.dart';
import 'package:tienda/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), 
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
        "/": (context) => HomePage(),  
        '/cartPage': (context) => CartPage(),
        "itemPage": (context) => ItemPage(), 
      },
    );
  }
}
