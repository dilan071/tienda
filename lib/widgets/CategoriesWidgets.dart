import 'package:flutter/material.dart';

/// Modelo para categoría de producto
class Category {
  final String imagePath;
  final String name;

  Category({required this.imagePath, required this.name});
}

class CategoriesWidgets extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategoryTap;

  const CategoriesWidgets({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (ctx, index) {
          final category = categories[index];
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onCategoryTap(index),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF4C53A5) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF4C53A5),
                  width: isSelected ? 0 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Image.asset(
                    category.imagePath,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Color(0xFF4C53A5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
