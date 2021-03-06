import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.dart';
// import 'package:provider/provider.dart';
// import 'package:shopp/providers/auth.dart';
import 'package:shopp/screens/orders_screen.dart';
import 'package:shopp/screens/user_products_screen.dart';

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
    // String? authData = Provider.of<Auth>(context).email;
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
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Our Shop!',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.red),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Text(
                  //     "Hello $authData",
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.w900,
                  //         fontSize: 15,
                  //         color: Colors.black),
                  //   ),
                  // ),
                ],
              )),
          const SizedBox(height: 10),
          // buildListTile('Meals', Icons.restaurant, () {
          //   Navigator.of(context).pushReplacementNamed('/');
          // }),
          buildListTile('Shop', Icons.shopping_basket, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          const Divider(
            thickness: 2.0,
            color: Colors.amber,
          ),
          buildListTile('Orders', Icons.shopping_cart_rounded, () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          }),
          const Divider(
            thickness: 2.0,
            color: Colors.amber,
          ),
          buildListTile('Manage Products', Icons.edit, () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName);
          }),
          const Divider(
            thickness: 2.0,
            color: Colors.amber,
          ),
          buildListTile('Logout', Icons.exit_to_app, () {
            // Navigator.of(context)
            //     .pushReplacementNamed(UserProductsScreen.routeName);
            //close the drawer first
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          }),
        ],
      ),
    );
  }
}
