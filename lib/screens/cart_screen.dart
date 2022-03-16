import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.dart';
import 'package:shopp/providers/orders.dart';
import 'package:shopp/widgets/cart_item.dart';

// ignore: use_key_in_widget_constructors
class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart Total'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Consumer<Cart>(
                      builder: (context, cart, child) => Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}'))),
                  OrderButton()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<Cart>(
              builder: (context, cart, child) => Expanded(
                  child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          id: cart.items.values.toList()[index].id,
                          title: cart.items.values.toList()[index].title,
                          quantity: cart.items.values.toList()[index].quantity,
                          price: cart.items.values.toList()[index].price,
                          productId: cart.items.keys.toList()[index],
                        );
                      })))
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class OrderButton extends StatefulWidget {
  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => TextButton(
          onPressed: (cart.totalAmount <= 0 || _isLoading)
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<Orders>(context, listen: false)
                      .addOrder(cart.items.values.toList(), cart.totalAmount);
                  setState(() {
                    _isLoading = false;
                  });
                  cart.clearCart();
                },
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'ORDER NOW',
                  style: TextStyle(color: Colors.black),
                )),
    );
  }
}
