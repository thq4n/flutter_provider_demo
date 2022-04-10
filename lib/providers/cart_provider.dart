import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _selectedItems = [];

  UnmodifiableListView<Product> get selectedItems =>
      UnmodifiableListView(_selectedItems);

  int get totalPrice {
    int a = 0;

    for (var item in _selectedItems) {
      a += (item.price ?? 0);
    }

    return a;
  }

  void add(Product item) {
    _selectedItems.add(item);

    notifyListeners();
  }

  void removeAll() {
    _selectedItems.clear();

    notifyListeners();
  }

  void remove(Product item) {
    _selectedItems.remove(item);

    notifyListeners();
  }

  String get beautifiedTotalPrice =>
      NumberFormat.currency(locale: 'vi').format(totalPrice);
}
