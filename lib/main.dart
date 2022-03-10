import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.dart';
import 'package:shopp/providers/orders.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/cart_screen.dart';
import 'package:shopp/screens/orders_screen.dart';
import 'package:shopp/screens/products_details_screen.dart';
import 'package:shopp/screens/products_overview_screen.dart';
import 'package:shopp/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Shopp',
        theme: ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.amber,
            errorColor: Colors.red,
            fontFamily: 'Lato'),
        // home: ProductOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => ProductOverviewScreen(),
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen()
        },
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopp'),
      ),
      body: const Center(
        child: Text('Shopp, a great place'),
      ),
    );
  }
}
