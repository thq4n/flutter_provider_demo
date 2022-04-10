import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_demo/data/dummy_data.dart';

import '../models/product.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Product> _products = DummyData.products;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  void add(Product item) {
    _products.add(item);

    notifyListeners();
  }
}
