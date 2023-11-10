import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/apis.dart';
import 'package:grocery_app/util/logs.dart';
import 'package:grocery_app/util/shopping_colors.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Sale {
  final String id;
  final int user_id;
  final int customer_id;
  final String currency;
  final double total_amount;
  final List<SaleProduct> products;
  final List<PaymentMethod> paymentmethods;

  Sale(
      {required this.id,
      required this.user_id,
      required this.customer_id,
      required this.currency,
      required this.total_amount,
      required this.products,
      required this.paymentmethods});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'customer_id': customer_id,
      'currency': currency,
      'total_amount': total_amount,
      'products': products.map((p) => p.toJson()).toList(),
      'paymentmethods': paymentmethods.map((p) => p.toJson()).toList(),
    };
  }
}

class SaleProduct {
  final String saleid;
  final String product_name;
  final int quantity;
  final double price;

  SaleProduct(
      {required this.saleid,
      required this.product_name,
      required this.quantity,
      required this.price});
  Map<String, dynamic> toJson() {
    return {
      'saleid': saleid,
      'product_name': product_name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class PaymentMethod {
  final String saleid;
  final String method_type;
  final double amount;

  PaymentMethod({required this.saleid, required this.method_type, required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'saleid': saleid,
      'method_type': method_type,
      'amount': amount,
    };
  }
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  bool isMakingSale = false;
  bool isGettingSale = false;
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total, context) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    makeSale(cartProducts, total, context);
    notifyListeners();
  }

  Future makeSale(List<CartItem> cartItems, double total, BuildContext context) async {
    Sale sale;
    String saleId = "1";
    List<PaymentMethod> paymentmethods = [];
    List<SaleProduct> products = [];
    for (CartItem cartItem in cartItems) {
      products.add(
        SaleProduct(
          saleid: saleId,
          product_name: cartItem.title,
          quantity: cartItem.quantity,
          price: cartItem.price,
        ),
      );
    }
    paymentmethods.add(PaymentMethod(saleid: saleId, method_type: "Cash", amount: total));
    sale = Sale(
        id: saleId,
        user_id: int.parse(MySharedPref.getUserId()),
        customer_id: 1,
        currency: "USD",
        total_amount: total,
        products: products,
        paymentmethods: paymentmethods);

    try {
      isMakingSale = true;
      notifyListeners();
      var data = sale.toJson();
      printSuccess("data: " + data.toString());
      Response response = await Apis.dio.post('/sales',
          data: data,
          options: Options(
              headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()}));
      if (response.statusCode == 200) {
        isMakingSale = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sale completed successfully',
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
      isMakingSale = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to complete sale',
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
      isMakingSale = false;
      notifyListeners();
    }
  }

  Future getSales(BuildContext context, String startDate, String endDate) async {
    Map<String, dynamic> data = {};
    data.addEntries({"startDate": startDate, "endDate": endDate}.entries);
    try {
      isGettingSale = true;
      notifyListeners();
      Response response = await Apis.dio.get('/sales/${MySharedPref.getUserId()}',
          queryParameters: data,
          options: Options(
              headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()}));
      if (response.statusCode == 200) {
        isGettingSale = false;
     
        notifyListeners();
      } else {
        isGettingSale = false;
        ///error
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to get sales',
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
      isGettingSale = false;
      notifyListeners();
    }
  }
}
