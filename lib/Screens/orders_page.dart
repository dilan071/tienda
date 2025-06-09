import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Pedidos'),
        backgroundColor: const Color(0xFF4C53A5),
      ),
      body:
          orders.isEmpty
              ? const Center(child: Text('Aún no hay pedidos realizados.'))
              : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                        order.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(order.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cantidad: ${order.quantity}'),
                          Text('Precio: \$${order.price.toStringAsFixed(2)}'),
                          Text(
                            'Fecha: ${order.date.toLocal().toString().split('.')[0]}',
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
