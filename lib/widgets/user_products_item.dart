import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  UserProductItem(
      {required this.title, required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    //ScaffoldMessenger.of(context) with context is no longer stable in the widget tree
                    scaffold.showSnackBar(SnackBar(
                        content: Text(
                      'Product with $id not deleted',
                      textAlign: TextAlign.center,
                    )));
                  }
                },
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
