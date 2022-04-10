import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/screens/add_product_screen.dart';
import 'package:flutter_provider_demo/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddProductScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('My Catalog'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        itemBuilder: (context, index) {
          final Product product = productsProvider.products.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 100,
              child: Card(
                elevation: 2,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: product.color,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              product.title?.toUpperCase() ?? '--',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              product.beautifiedPrice,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          cartProvider.selectedItems.contains(product) != true
                              ? Icons.add_shopping_cart
                              : Icons.check),
                      onPressed:
                          cartProvider.selectedItems.contains(product) != true
                              ? () => cartProvider.add(product)
                              : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: productsProvider.products.length,
      ),
    );
  }
}


