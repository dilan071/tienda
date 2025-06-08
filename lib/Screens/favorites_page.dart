 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/ItemsWidget.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        backgroundColor: const Color(0xFF4C53A5),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No tienes productos en favoritos'))
          : ItemsWidget(productos: favorites),
    );
  }
}