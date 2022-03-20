import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ScaffoldWidget extends StatelessWidget {
  // final String appBarTitle;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ScaffoldWidget();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        //     appBar: AppBar(
        //   title: Text(appBarTitle),
        // ));
        body: const Center(child: Text('Loading....')));
  }
}
