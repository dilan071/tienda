import 'package:flutter/material.dart';
import 'package:tienda/pages/CartPage.dart';
import 'package:tienda/pages/Homepage.dart';
import 'package:tienda/pages/ItemPage.dart';

// Run | Debug | Profile
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
            ), // ThemeData
            routes: {
                "/": (context) => HomePage(),
                "cartPage": (context) => CartPage(),
                "itemPage": (context) => ItemPage()
            },
        ); // MaterialApp
    }
}