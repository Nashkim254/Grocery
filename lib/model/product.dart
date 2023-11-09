import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  String stock;
  String currency;
  int quantity;
  final String imageUrl;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.currency,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
