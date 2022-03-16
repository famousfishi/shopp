import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopp/models/http_exception.dart';
import 'package:shopp/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  //create a List of your Products
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 30.00,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 60.00,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 20.00,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 50.00,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  //return a copy of your items using the spread operator

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouritesItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        //remove the appended base url to url constants file
        'https://shopp-fishi-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFavourite": product.isFavourite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);
      // _items.insert(0, newProduct); // adds it at the beginning of the list

      notifyListeners();
    } catch (error) {
      //throw weeror is important if we are going to use async await in our widget and return a widget in usage of this error
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  //for getting products data from WEB API / firrbase  database (server)
  Future<void> getProducts() async {
    final url = Uri.parse(
        //remove the appended base url to url constants file
        'https://shopp-fishi-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final List<Product> loadedProducts = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            description: productData['description'],
            title: productData['title'],
            imageUrl: productData['imageUrl'],
            isFavourite: productData['isFavourite'],
            price: productData['price']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

// for updating a product
  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          //remove the appended base url to url constants file
          'https://shopp-fishi-default-rtdb.firebaseio.com/products/$id.json');
      try {
        await http.patch(url,
            body: json.encode({
              "title": newProduct.title,
              "description": newProduct.description,
              "imageUrl": newProduct.imageUrl,
              "price": newProduct.price,
            }));
        _items[productIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        // ignore: use_rethrow_when_possible
        throw error;
      }
    }
  }

  //for deleteing a product
  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        //remove the appended base url to url constants file
        'https://shopp-fishi-default-rtdb.firebaseio.com/products/$id.json');

//get the existing product index
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);

    //then get the existing product using the existing product index
    Product? existingProduct = _items[existingProductIndex];

//utililizing optimistic updating
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete product with ID $id');
    }
    existingProduct = null;
  }
}
