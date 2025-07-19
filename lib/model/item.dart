import 'package:flutter/material.dart';

class Item {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final Color color;

  Item({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.color = Colors.white
  });
}
