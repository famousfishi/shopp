import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/edit_products_screen.dart';
import 'package:shopp/widgets/main_drawer.dart';
import 'package:shopp/widgets/user_products_item.dart';

// ignore: use_key_in_widget_constructors
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Personal Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: MainDrawer(), //

      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    UserProductItem(
                        id: productsData.items[index].id,
                        title: productsData.items[index].title,
                        imageUrl: productsData.items[index].imageUrl),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1.0,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
