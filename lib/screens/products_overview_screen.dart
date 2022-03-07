import 'package:flutter/material.dart';
import 'package:shopp/widgets/products_grid.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favourites,
  // ignore: constant_identifier_names
  ShowAll
}

// ignore: use_key_in_widget_constructors
class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  List<PopupMenuEntry<dynamic>> popUpMenuOptions = [
    const PopupMenuItem(
      child: Text('Only favourites'),
      value: FilterOptions.Favourites,
    ),
    const PopupMenuItem(
      child: Text('Show All'),
      value: FilterOptions.ShowAll,
    )
  ];

  bool _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Overview'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return popUpMenuOptions;
            },
            icon: const Icon(Icons.more_vert),
            onSelected: (dynamic selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
