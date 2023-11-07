import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'category.dart';
import 'products.dart';
import 'package:provider/provider.dart';

import './product.dart';

class Categories with ChangeNotifier {
  final dio = Dio();
  bool isCategoriesLoading = false;
  bool isProductsLoading = false;
  bool isProductsbyIdLoading = false;
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> productsById = [];
  List<Category> _items = [
    Category(
        id: 'c1',
        title: 'Fresh Fruits',
        imageUrl: 'shopping_assets/images/fruits/cover.png',
        products: ['p1', 'p2', 'p3', 'p4', 'p5', 'p6']),
    Category(
      id: 'c4',
      title: 'Bakery &\nSnacks',
      imageUrl: 'shopping_assets/images/bakery_snacks/cover.png',
    ),
    Category(
      id: 'c6',
      title: 'Beverage',
      imageUrl: 'shopping_assets/images/beverage/cover.png',
    ),
    Category(
      id: 'c5',
      title: 'Dairy &\nEggs',
      imageUrl: 'shopping_assets/images/dairy_eggs/cover.png',
    ),
    Category(
        id: 'c2',
        title: 'Vegetables',
        imageUrl: 'shopping_assets/images/vegetables/vegetables_cover.png',
        products: ['p7', 'p8', 'p9', 'p10', 'p11', 'p12']),
    Category(
      id: 'c3',
      title: 'Cooking Oil',
      imageUrl: 'shopping_assets/images/cooking_oil/cooking_cover.png',
    ),
    Category(
        id: 'c6',
        title: 'Fruits',
        imageUrl: 'shopping_assets/images/fruits/cover.png',
        products: ['p1', 'p2', 'p5', 'p6']),
    Category(
      id: 'c7',
      title: 'Snacks',
      imageUrl: 'shopping_assets/images/bakery_snacks/cover.png',
    ),
    Category(
      id: 'c8',
      title: 'Eggs',
      imageUrl: 'shopping_assets/images/dairy_eggs/cover.png',
    ),
  ];

  // var _showFavoritesOnly = false;

  List<Category> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> getProductsById(BuildContext context, String id) {
    List<Product> list = [];
    for (String productId in _items.firstWhere((cat) => cat.id == id).products!) {
      list.add(Provider.of<Products>(context).findById(productId));
    }
    return list;
  }

  Category findCategoryByTitle(String categoryTitle) {
    return _items.firstWhere((prod) => prod.title.contains(categoryTitle));
  }

  Category findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  /// get categories from dummy helper
  getCategories(String id) async {
    // categories = DummyHelper.categories;
    debugPrint("hit get category");
    debugPrint("hit get category $id");

    try {
      isCategoriesLoading = true;
      notifyListeners();
      Response response = await dio.get(
        Constants.baseUrl + '/getcategories/$id',
        options: Options(
          headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()},
        ),
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        categories.clear();
        isCategoriesLoading = false;
        debugPrint(response.data.toString());
        var data = response.data;
        for (int i = 0; i < data.length; i++) {
          print("looping on category $i");
          categories.add(
            Category(
              id: data[i]['id'],
              title: data[i]['CatogeryName'],
              imageUrl: data[i]['CategoryIcon'],
            ),
          );
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
      isCategoriesLoading = false;
      notifyListeners();
    }
  }

 /// get products by category id
  /// get categories from dummy helper
 Future<List<Product>> getProducts(String cid, String oid) async {
    // categories = DummyHelper.categories;
    // products = DummyHelper.products;
    try {
      isProductsbyIdLoading = true;
      Response response = await dio.get(
        Constants.baseUrl + '/categories/$cid/$oid',
       options: Options(
         headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()},
       )
      );

      if (response.statusCode == 200) {
        products.clear();
        isProductsbyIdLoading = false;
        debugPrint(response.data.toString());
        var data = response.data['products'];
        for (int i = 0; i < data.length; i++) {
          productsById.add(Product(
              id: data[i]['ID'],
              imageUrl: data[i]['Image'],
              title: data[i]['ProductName'],
              quantity: data[i]['Stock'],
              stock: data[i]['Quantity'],
              price: double.parse(data[i]['Price'].toString()),
              description: data[i]['Description']));
        }

        ///data successfully
      } else {
        ///error
        debugPrint("error getting pro data");
        print(response.statusCode);
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isProductsbyIdLoading = false;
    }
    return productsById;
  }
}
