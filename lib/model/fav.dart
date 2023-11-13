import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/apis.dart';
import 'package:grocery_app/util/logs.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class FavItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  FavItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class Fav with ChangeNotifier {
  bool isAddingFavorite = false;
  Map<String, FavItem> _items = {};

  Map<String, FavItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, favItem) {
      total += favItem.price * favItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId, double price, String title, String imageUrl, BuildContext context) {
    if (_items.containsKey(productId)) {
      // change quantity...
      late FavItem item;
      _items.update(
          productId,
          (existingFavItem) => item = FavItem(
                id: existingFavItem.id,
                title: existingFavItem.title,
                price: existingFavItem.price,
                quantity: existingFavItem.quantity + 1,
                imageUrl: imageUrl,
              ));
      addFav(context, productId, item.quantity);
    } else {
      _items.putIfAbsent(
        productId,
        () => FavItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
      addFav(context, productId, 1);
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => FavItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                imageUrl: existingCartItem.imageUrl,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future addFav(BuildContext context, String productId, int quantity) async {
    printSuccess("Add to favorites");
    printError(productId);
    printError(quantity);
    try {
      isAddingFavorite = true;
      notifyListeners();
      Map<String, dynamic> data = {};
      String id = DateTime.now().hashCode.toString();
      data.addEntries({
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "userid": MySharedPref.getUserId()
      }.entries);
      printSuccess("data: " + data.toString());
      Response response = await Apis.dio.post('/favorites',
          data: data,
          options: Options(
              headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()}));
      if (response.statusCode == 200) {
        isAddingFavorite = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added to favorites',
            ),
            duration: Duration(seconds: 2),
            backgroundColor: primaryColor,
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
        notifyListeners();
      } else {
        ///error
        isAddingFavorite = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add to favorites',
            ),
            duration: Duration(seconds: 2),
            backgroundColor: redColor,
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      }
    } catch (e) {
      print('Error  is $e');
    } finally {
      isAddingFavorite = false;
      notifyListeners();
    }
  }
}
