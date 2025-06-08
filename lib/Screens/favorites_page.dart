// lib/Screens/favorites_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import '../providers/favorites_provider.dart';
import '../widgets/ItemsWidget.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenemos la lista de IDs marcados como favoritos
    final favIds = context.watch<FavoritesProvider>().favIds;
    // Obtenemos todos los productos desde el ProductController
    final allProducts = context.watch<ProductController>().products;
    // Filtramos únicamente los productos cuyos IDs estén en favIds
    final favorites = allProducts.where((p) => favIds.contains(p.id)).toList();

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
