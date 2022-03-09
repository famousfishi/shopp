import 'package:flutter/material.dart';
import 'package:shopp/screens/orders_screen.dart';

// ignore: use_key_in_widget_constructors
class MainDrawer extends StatelessWidget {
  Widget buildListTile(String text, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // AppBar(
          //   title: const Text('Hello friends'),
          //   automaticallyImplyLeading: false,
          // ),
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            // decoration: BoxDecoration(
            //     color: Colors.amberAccent,
            //     border: Border.all(color: Colors.black)),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Our Shop!',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 30, color: Colors.red),
            ),
          ),
          const SizedBox(height: 10),
          // buildListTile('Meals', Icons.restaurant, () {
          //   Navigator.of(context).pushReplacementNamed('/');
          // }),
          buildListTile('Products', Icons.ac_unit, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          const Divider(
            thickness: 2.0,
            color: Colors.amber,
          ),
          buildListTile('Orders', Icons.shopping_cart_rounded, () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
