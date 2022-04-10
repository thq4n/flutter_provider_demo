import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/providers/cart_provider.dart';
import 'package:flutter_provider_demo/providers/product_provider.dart';
import 'package:flutter_provider_demo/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
      ],
      child: const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
