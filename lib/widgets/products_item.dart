import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  ProductItem({required this.id, required this.title, required this.imageUrl});

  Widget buildIconButton(
      IconData iconData, Function() tapIcon, BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: tapIcon,
      color: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          leading: buildIconButton(Icons.favorite, () {}, context),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: buildIconButton(Icons.shopping_cart, () {}, context),
        ),
      ),
    );
  }
}
