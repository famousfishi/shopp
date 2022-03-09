import 'package:flutter/foundation.dart';
import 'package:shopp/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  //count/length of cart items
  int get cartItemsCount {
    return _items.length;
  }

  //totalAmount of cart items
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      //total = price * quantity
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeCartItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //cleart cart after order has been placed
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
