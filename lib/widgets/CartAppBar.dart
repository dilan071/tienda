import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 25);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Cart",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => _buildMoreOptionsSheet(context),
            ),
            child: Icon(
              Icons.more_vert,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreOptionsSheet(BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text("Vaciar carrito"),
          onTap: () {
           
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text("Cancelar"),
          onTap: () => Navigator.pop(ctx),
        ),
      ],
    );
  }
}
