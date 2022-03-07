import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.dart';
import 'package:shopp/screens/products_details_screen.dart';

// ignore: use_key_in_widget_constructors
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  // ProductItem({required this.id, required this.title, required this.imageUrl});

  Widget buildIconButton(
      IconData iconData, Function() tapIcon, BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: tapIcon,
      color: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context);

    // return Consumer<Product>(
    // builder: (context, product, child) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, _) {
                return buildIconButton(
                    product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    product.toggleFavouriteStatus,
                    context);
              },
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: buildIconButton(Icons.shopping_cart, () {}, context),
          ),
        ),
      ),
    );
    // },
  }
}
