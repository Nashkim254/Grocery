import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';

import './product.dart';

class Products with ChangeNotifier {
  final dio = Dio();
  static String dummyDesc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
  bool isProductsLoading = false;
  List<Product> products = [];
  // List<Product> products = [
  //   /// Fruits Products
  //   Product(
  //     id: 'p1',
  //     title: 'Apple/kg',
  //     price: 80,
  //     imageUrl:
  //         'shopping_assets/images/fruits/apple.png',
  //     description: dummyDesc,
  //   ),

  //   Product(
  //     id: 'p5',
  //     title: 'Orange/dz',
  //     price: 60,
  //     imageUrl:
  //     'shopping_assets/images/fruits/orange.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p6',
  //     title: 'PineApple/pc',
  //     price: 50,
  //     imageUrl:
  //     'shopping_assets/images/fruits/pineapple.png',
  //     description: dummyDesc,
  //   ),

  //   Product(
  //     id: 'p2',
  //     title: 'Banana/dz',
  //     price: 40,
  //     imageUrl:
  //     'shopping_assets/images/fruits/banana.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Lemon/dz',
  //     price: 30,
  //     imageUrl:
  //     'shopping_assets/images/fruits/lemon.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'Mango/dz',
  //     price: 50,
  //     imageUrl:
  //     'shopping_assets/images/fruits/mango.png',
  //     description: dummyDesc,
  //   ),
  //   /// Vegetable Products
  //   Product(
  //     id: 'p7',
  //     title: 'Carrot/kg',
  //     price: 20,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/carrot.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p8',
  //     title: 'Cucumber/kg',
  //     price: 40,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/cucumber.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p9',
  //     title: 'Onion/kg',
  //     price: 90,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/onion.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p10',
  //     title: 'Potato/kg',
  //     price: 60,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/potato.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p11',
  //     title: 'RedChillies/kg',
  //     price: 50,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/red_chillies.png',
  //     description: dummyDesc,
  //   ),
  //   Product(
  //     id: 'p12',
  //     title: 'Tomato/kg',
  //     price: 40,
  //     imageUrl:
  //     'shopping_assets/images/vegetables/tomato.png',
  //     description: dummyDesc,
  //   ),
  // ];
  // var _showFavoritesOnly = false;
  /// get categories from dummy helper
  getProducts(String id) async {
    // categories = DummyHelper.categories;
    // products = DummyHelper.products;
    debugPrint("hit get category");
    debugPrint("hit get category $id");
    debugPrint("hit get category ${Constants.baseUrl + '/products/$id/10/0'}");
    try {
      isProductsLoading = true;
      Response response = await dio.get(
        Constants.baseUrl + '/products/$id/10/0',
        options: Options(
          headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()},
        )
      );

      if (response.statusCode == 200) {
        products.clear();
        isProductsLoading = false;
        debugPrint(response.data.toString());
        var data = response.data;
        for (int i = 0; i < data['Products'].length; i++) {
          print("looping on category $i");
          products.add(Product(
              id: data['Products'][i]['ID'],
              imageUrl: data['Products'][i]['Image'],
              title: data['Products'][i]['Product_name'],
              quantity: data['Products'][i]['Stock'],
              stock: data['Products'][i]['Quantity'],
              price: double.parse(data['Products'][i]['Price'].toString()),
              description: data['Products'][i]['Description']));
        }

        ///data successfully
      } else {
        ///error
        debugPrint("error getting category data");
        print(response.statusCode);
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isProductsLoading = false;
    }
  }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return products.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...products];
  }

  List<Product> get favoriteItems {
    return products.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return products.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: product.quantity,
      stock: product.stock,
      id: DateTime.now().toString(),
      description: product.description
    );
    products.add(newProduct);
    // products.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = products.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      products[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
