import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final String description;

  // ProductDetailsScreen({required this.title, required this.description});

  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: const Center(
        child: Text('description'),
      ),
    );
  }
}
