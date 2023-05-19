import 'package:flutter/material.dart';
import 'package:pricelet_app/app_routes.dart';
import 'package:pricelet_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
    );
  }
}
