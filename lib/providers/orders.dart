import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopp/models/cart_item.dart';
import 'package:shopp/models/order_item.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

//copy a new list to the orders and use the spread operator
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        //remove the appended base url to url constants file
        'https://shopp-fishi-default-rtdb.firebaseio.com/orders.json');

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        //remove the appended base url to url constants file
        'https://shopp-fishi-default-rtdb.firebaseio.com/orders.json');

    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price
                  })
              .toList()
        }));

    //using insert as it adds each item at the beginning of the list and shifts each towards the end of the list
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: timeStamp,
            id: json.decode(response.body)['name'],
            products: cartProducts));

    notifyListeners();
  }
}
