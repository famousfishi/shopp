import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.dart';
import 'package:shopp/providers/products.dart';

// ignore: use_key_in_widget_constructors
class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final String description;

  // ProductDetailsScreen({required this.title, required this.description});

  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    Product product =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text(product.description),
      ),
    );
  }
}
