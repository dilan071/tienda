// lib/pages/HomePage.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../controllers/filter_controller.dart';
import '../controllers/product_controller.dart';  
import '../providers/cart_provider.dart';

import '../widgets/CategoriesWidgets.dart';
import '../widgets/HomeAppBar.dart';
import '../widgets/ItemsWidget.dart';
import '../widgets/loading.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  double? _minPrice;
  double? _maxPrice;

  final List<Category> _categories = [
    Category(imagePath: 'images/1.png', name: 'Jewelry'),
    Category(imagePath: 'images/2.png', name: 'Men Clothing'),
    Category(imagePath: 'images/3.png', name: 'Electronics'),
    Category(imagePath: 'images/4.png', name: 'Women Clothing'),
  ];

  final List<String> _apiCategories = [
    'jewelery',
    "men's clothing",
    'electronics',
    "women's clothing",
  ];

  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Al iniciar, carga la primera categoría
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchCategory());
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _fetchCategory() {
    // Llama al controller en lugar del provider
    context.read<ProductController>()
      .fetchByCategory(_apiCategories[_selectedCategoryIndex]);
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _searchQuery = '';
      _minPrice = null;
      _maxPrice = null;
      _minPriceController.clear();
      _maxPriceController.clear();
    });
    _fetchCategory();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _updatePriceRange(double? min, double? max) {
    setState(() {
      _minPrice = min;
      _maxPrice = max;
    });
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _minPrice = null;
      _maxPrice = null;
      _minPriceController.clear();
      _maxPriceController.clear();
    });
  }

  Future<void> _showFavoritesOrdersMenu() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
            onTap: () => Navigator.pop(context, 'favorites'),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historial de Pedidos'),
            onTap: () => Navigator.pop(context, 'orders'),
          ),
        ],
      ),
    );
    if (selected == 'favorites') {
      Navigator.pushNamed(context, '/favorites');
    } else if (selected == 'orders') {
      Navigator.pushNamed(context, '/orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, productCtrl, _) {
        // Aplica filtros usando FilterController
        final filteredProducts = FilterController.filterProducts(
          products: productCtrl.products,
          searchQuery: _searchQuery,
          minPrice: _minPrice,
          maxPrice: _maxPrice,
        );

        return Scaffold(
          body: ListView(
            children: [
              HomeAppBar(
                cartItemCount: context.watch<CartProvider>().items.length,
                onCartTap: () => Navigator.pushNamed(context, '/cartPage'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEDCF2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    // Título Categorías
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    ),
                    // Lista horizontal de categorías
                    CategoriesWidgets(
                      categories: _categories,
                      selectedIndex: _selectedCategoryIndex,
                      onCategoryTap: _onCategoryTap,
                    ),

                    const SizedBox(height: 10),

                    // Barra de búsqueda
                    ProductSearchBar(onChanged: _updateSearchQuery),

                    const SizedBox(height: 10),

                    // Filtros de precio + botón limpiar filtros
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _minPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Precio mínimo',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (v) {
                                final p = double.tryParse(v);
                                _updatePriceRange(p, _maxPrice);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _maxPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Precio máximo',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (v) {
                                final p = double.tryParse(v);
                                _updatePriceRange(_minPrice, p);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _clearFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Limpiar filtros'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Título Best Selling
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: const Text(
                        'Best Selling',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    ),

                    // Estado de carga / error / lista filtrada
                    if (productCtrl.isLoading)
                      const Loading()
                    else if (productCtrl.errorMessage != null)
                      Center(
                        child: Text(
                          productCtrl.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    else if (filteredProducts.isEmpty)
                      const EmptyState()
                    else
                      ItemsWidget(productos: filteredProducts),
                  ],
                ),
              ),
            ],
          ),

          // Navegación curva inferior
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            height: 70,
            color: const Color(0xFF4C53A5),
            items: const [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(CupertinoIcons.cart_fill, size: 30, color: Colors.white),
              Icon(Icons.favorite, size: 30, color: Colors.white),
            ],
            onTap: (index) async {
              if (index == 1) {
                Navigator.pushNamed(context, '/cartPage');
              } else if (index == 2) {
                await _showFavoritesOrdersMenu();
              }
            },
          ),
        );
      },
    );
  }
}
