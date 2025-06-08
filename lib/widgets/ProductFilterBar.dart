import 'package:flutter/material.dart';

class ProductFilterBar extends StatelessWidget {
  final Function(String) onNameChanged;
  final Function(String) onCategoryChanged;
  final Function(double, double) onPriceRangeChanged;

  const ProductFilterBar({
    required this.onNameChanged,
    required this.onCategoryChanged,
    required this.onPriceRangeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    String selectedCategory = 'Todas';
    double minPrice = 0;
    double maxPrice = 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔍 Nombre
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Buscar por nombre',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: onNameChanged,
        ),
        SizedBox(height: 12),

        // 📂 Categoría
        DropdownButtonFormField<String>(
          value: selectedCategory,
          decoration: InputDecoration(
            labelText: 'Filtrar por categoría',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: ['Todas', 'Tecnología', 'Hogar', 'Moda', 'Juguetes']
              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
              .toList(),
          onChanged: (value) {
            onCategoryChanged(value ?? 'Todas');
          },
        ),
        SizedBox(height: 12),

        // 💵 Precio mínimo y máximo
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Precio mínimo'),
                onChanged: (value) {
                  minPrice = double.tryParse(value) ?? 0;
                  onPriceRangeChanged(minPrice, maxPrice);
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Precio máximo'),
                onChanged: (value) {
                  maxPrice = double.tryParse(value) ?? 1000;
                  onPriceRangeChanged(minPrice, maxPrice);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
