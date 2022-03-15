import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/cart_screen.dart';
import 'package:shopp/widgets/badge.dart';
import 'package:shopp/widgets/main_drawer.dart';
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
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).getProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Cart cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Retail Shop'),
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
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                value: cart.cartItemsCount.toString()),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourites),
    );
  }
}
