import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/products_details_screen.dart';
import 'package:shopp/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Shopp',
        theme: ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.amber,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen()
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
