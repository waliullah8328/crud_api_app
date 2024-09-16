
import 'package:crud_api_app/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CrudMyApp extends StatelessWidget {
  const CrudMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}
