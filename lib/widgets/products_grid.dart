import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/widgets/products_item.dart';

// ignore: use_key_in_widget_constructors
class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context);

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: products.items[index],
            // create: (BuildContext context) => products.items[index],
            child: ProductItem(
                // id: products.items[index].id,
                // imageUrl: products.items[index].imageUrl,
                // title: products.items[index].title,
                ),
          );
        });
  }
}
