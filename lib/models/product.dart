import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Product {
  String? title;
  Color? color;
  int? price;

  Product({
    this.title,
    this.color,
    this.price,
  });

  String get beautifiedPrice =>
      NumberFormat.currency(locale: 'vi').format(price);
}
