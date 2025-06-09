// lib/widgets/HomeAppBar.dart
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount;
  final VoidCallback onCartTap;
  final VoidCallback? onMenuTap; // NUEVO

  const HomeAppBar({
    Key? key,
    required this.cartItemCount,
    required this.onCartTap,
    this.onMenuTap, // NUEVO
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 25);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.sort, size: 30, color: Color(0xFF4C53A5)),
            onPressed: onMenuTap, // USAMOS onMenuTap
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "DP Shop",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          Spacer(),
          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: Text(
              cartItemCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: InkWell(
              onTap: onCartTap,
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 32,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
