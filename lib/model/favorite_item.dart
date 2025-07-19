import 'package:flutter/material.dart';

class FavoriteItem {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final Color color;

  FavoriteItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.color,
  });
}
