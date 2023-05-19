import 'package:flutter/material.dart';
import 'package:pricelet_app/home_page.dart';
import 'package:pricelet_app/shopping_cart.dart';

class AppRoutes {
  static const String home = '/';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(homeTitle: 'Pricelet App'),
    cart: (context) => const ShoppingCard(),
  };
}
