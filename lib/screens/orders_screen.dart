import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/orders.dart';
import 'package:shopp/widgets/main_drawer.dart';
import 'package:shopp/widgets/order_item.dart';

// ignore: use_key_in_widget_constructors
class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: MainDrawer(), //
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) {
            return OrderItemm(orderItem: orderData.orders[index]);
          }),
    );
  }
}
