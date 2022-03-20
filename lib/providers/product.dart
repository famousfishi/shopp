import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  //chnaged to dynamic as errors with null and string came topping up
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  void setFavouriteStatusValue(bool status) {
    isFavourite = status;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String? token, String? userId) async {
    bool oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    try {
      final url = Uri.parse(
          //remove the appended base url to url constants file
          'https://shopp-fishi-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');

      final response = await http.put(url, body: json.encode(isFavourite));

      if (response.statusCode >= 400) {
        setFavouriteStatusValue(oldStatus);
      }
    } catch (error) {
      setFavouriteStatusValue(oldStatus);

      // // ignore: use_rethrow_when_possible
      // throw error;
    }
  }
}
