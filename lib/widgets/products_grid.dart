import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/widgets/products_item.dart';

// ignore: use_key_in_widget_constructors
class ProductsGrid extends StatelessWidget {
  final bool _showFavourites;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ProductsGrid(this._showFavourites);
  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context);

    List<Product> productsData =
        _showFavourites ? products.favouritesItems : products.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: productsData[index],
            // create: (BuildContext context) => productsData[index],
            child: ProductItem(
                // id: productsData[index].id,
                // imageUrl: productsData[index].imageUrl,
                // title: productsData[index].title,
                ),
          );
        });
  }
}
