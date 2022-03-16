import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/orders.dart';
import 'package:shopp/widgets/main_drawer.dart';
import 'package:shopp/widgets/order_item.dart';

// ignore: use_key_in_widget_constructors
class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // bool _isLoading = false;

  late Future _ordersFuture;

  Future _ordersLoadedFuture() {
    return Provider.of<Orders>(
      context,
      listen: false,
    ).fetchOrders();
  }

  @override
  void initState() {
    _ordersFuture = _ordersLoadedFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: MainDrawer(), //
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  // ...
                  // Do error handling stuff
                  return const Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (context, index) => OrderItemm(
                        orderItem: orderData.orders[index],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
