import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.dart';
import 'package:shopp/providers/cart.dart';
import 'package:shopp/providers/orders.dart';
import 'package:shopp/providers/products.dart';
import 'package:shopp/screens/auth_screen.dart';
import 'package:shopp/screens/cart_screen.dart';
import 'package:shopp/screens/edit_products_screen.dart';
import 'package:shopp/screens/orders_screen.dart';
import 'package:shopp/screens/products_details_screen.dart';
import 'package:shopp/screens/products_overview_screen.dart';
import 'package:shopp/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products("", []),
            update: (context, auth, previousProducts) => Products(auth.token,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),
        ],
        //for managing the auth token locally in the App, use consumer around the MaterialAPP
        child: Consumer<Auth>(
            builder: (context, authData, _) => MaterialApp(
                  title: 'Shopp',
                  theme: ThemeData(
                      primarySwatch: Colors.amber,
                      primaryColor: Colors.amber,
                      errorColor: Colors.red,
                      fontFamily: 'Lato'),
                  home:
                      authData.isAuth ? ProductOverviewScreen() : AuthScreen(),
                  debugShowCheckedModeBanner: false,
                  routes: {
                    // ProductOverviewScreen.routeName: (context) =>
                    //     ProductOverviewScreen(),
                    ProductDetailsScreen.routeName: (context) =>
                        ProductDetailsScreen(),
                    CartScreen.routeName: (context) => CartScreen(),
                    OrdersScreen.routeName: (context) => OrdersScreen(),
                    UserProductsScreen.routeName: (context) =>
                        UserProductsScreen(),
                    EditProductScreen.routeName: (context) =>
                        EditProductScreen()
                  },
                )));
  }
}

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopp'),
      ),
      body: const Center(
        child: Text('Shopp, a great place'),
      ),
    );
  }
}
