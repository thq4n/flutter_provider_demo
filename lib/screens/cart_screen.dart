import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: cartProvider.selectedItems.isNotEmpty == true
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                    itemBuilder: (context, index) {
                      final Product product =
                          cartProvider.selectedItems.elementAt(index);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => cartProvider.remove(product),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cartProvider.selectedItems.length,
                  )
                : const Center(
                    child: Text(
                      'Cart is empty',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total: ${cartProvider.beautifiedTotalPrice}',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
