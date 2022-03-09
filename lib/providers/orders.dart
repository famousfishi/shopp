import 'package:flutter/material.dart';
import 'package:shopp/models/cart_item.dart';
import 'package:shopp/models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

//copy a new list to the orders and use the spread operator
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    //using insert as it adds each item at the beginning of the list and shifts each towards the end of the list
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: cartProducts));

    notifyListeners();
  }
}
