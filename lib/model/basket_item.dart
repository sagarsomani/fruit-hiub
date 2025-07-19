import 'package:flutter/material.dart';

class BasketItem {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final int quantity;
  final Color color;

  BasketItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
     this.color = Colors.white,
  });

  BasketItem copyWith({int? quantity}) {
    return BasketItem(
      id: id,
      title: title,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
      color: color,
    );
  }
}
