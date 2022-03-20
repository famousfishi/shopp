import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.dart';
import 'package:shopp/providers/cart.dart';
import 'package:shopp/providers/product.dart';
import 'package:shopp/screens/products_details_screen.dart';

// ignore: use_key_in_widget_constructors
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  // ProductItem({required this.id, required this.title, required this.imageUrl});

  // Widget buildIconButton(
  //     IconData iconData, Future<void> tapIcon, BuildContext context) {
  //   return IconButton(
  //     icon: Icon(iconData),
  //     onPressed: () => tapIcon,
  //     color: Colors.amber,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //get the product provider
    Product product = Provider.of<Product>(context);

    //get the auth provider
    Auth authData = Provider.of<Auth>(context, listen: false);

    //get the cart provider
    Cart cart = Provider.of<Cart>(context, listen: false);

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
              builder: (context, product, _) => IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.amber,
                onPressed: () {
                  product.toggleFavouriteStatus(
                      authData.token, authData.userId);
                },
              ),
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Added item to cart!',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
    // },
  }
}
