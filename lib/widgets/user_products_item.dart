import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  UserProductItem({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {},
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
