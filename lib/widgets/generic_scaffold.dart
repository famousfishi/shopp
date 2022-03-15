import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ScaffoldWidget extends StatelessWidget {
  final String appBarTitle;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ScaffoldWidget({required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(appBarTitle),
    ));
  }
}
