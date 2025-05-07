import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tienda/widgets/CategoriesWidgets.dart';
import 'package:tienda/widgets/HomeAppBar.dart';
import 'package:tienda/widgets/ItemsWidget.dart';

class Product {
  final String imagePath;
  final String title;
  final String description;
  final double price;
  final int discount;
  final String category;

  Product({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.category,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> _categories = [
    Category(imagePath: 'images/1.png', name: 'Sandals'),
    Category(imagePath: 'images/2.png', name: 'Watches'),
    Category(imagePath: 'images/3.png', name: 'Bags'),
    Category(imagePath: 'images/4.png', name: 'Heels'),
    Category(imagePath: 'images/5.png', name: 'Boots'),
    Category(imagePath: 'images/6.png', name: 'Casual'),
    Category(imagePath: 'images/7.png', name: 'Sports'),
  ];

  int _selectedCategoryIndex = 0;
  bool _isLoading = true;
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  final List<Product> _allProducts = [
    Product(
      imagePath: 'images/1.png',
      title: 'Tacones',
      description: 'Tacones para mujer.',
      price: 55.0,
      discount: 50,
      category: 'Heels',
    ),
    Product(
      imagePath: 'images/2.png',
      title: 'Reloj clásico',
      description: 'Reloj de pulsera con correa de acero inoxidable.',
      price: 120.0,
      discount: 20,
      category: 'Watches',
    ),
    Product(
      imagePath: 'images/3.png',
      title: 'Bolso elegante',
      description: 'Bolso elegante para lucir.',
      price: 75.0,
      discount: 30,
      category: 'Bags',
    ),
    Product(
      imagePath: 'images/4.png',
      title: 'Botas deportivas',
      description: 'Botas cómodas para correr.',
      price: 85.0,
      discount: 15,
      category: 'Boots',
    ),
    Product(
      imagePath: 'images/5.png',
      title: 'Sandalias casual',
      description: 'Sandalias para el día a día.',
      price: 45.0,
      discount: 10,
      category: 'Sandals',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    _filterProducts();

    setState(() {
      _isLoading = false;
    });
  }

  void _filterProducts() {
    final category = _categories[_selectedCategoryIndex].name.toLowerCase();
    final query = _searchQuery.toLowerCase();

    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesCategory = product.category.toLowerCase() == category || category == 'all'; // allow all categories
        final matchesSearch = product.title.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _loadProducts();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
    _filterProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(
            cartItemCount: 3,
            onCartTap: () => Navigator.pushNamed(context, "/cartPage"),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFFEDCF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                // 🔍 Buscador
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search here...',
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: Color(0xFF4C53A5)),
                    ],
                  ),
                ),
                // 📂 Categorías
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                CategoriesWidgets(
                  categories: _categories,
                  selectedIndex: _selectedCategoryIndex,
                  onCategoryTap: _onCategoryTap,
                ),
                // 🔝 Título de sección
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Text(
                    'Best Selling',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                // ⌛ Loading / 😞 Empty / ✅ Productos
                if (_isLoading)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  )
                else if (_filteredProducts.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          'No se encontraron productos.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                else
                  ItemsWidget(
                    productos: _filteredProducts.map((p) => {
                          'imagen': p.imagePath,
                          'titulo': p.title,
                          'descripcion': p.description,
                          'precio': p.price,
                          'descuento': p.discount,
                        }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {},
        height: 70,
        color: Color(0xFF4C53A5),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(CupertinoIcons.cart_fill, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
