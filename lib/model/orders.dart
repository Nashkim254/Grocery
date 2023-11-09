import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/apis.dart';

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
  final String user_id;
  final String customer_id;
  final String currency;
  final double amount;
  final List<SaleProduct> product;
  final List<PaymentMethod> paymentMethods;

  Sale(
      {required this.id,
      required this.user_id,
      required this.customer_id,
      required this.currency,
      required this.amount,
      required this.product,
      required this.paymentMethods});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'customer_id': customer_id,
      'currency': currency,
      'amount': amount,
      'product': product.map((p) => p.toJson()).toList(),
      'paymentMethods': paymentMethods.map((p) => p.toJson()).toList(),
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
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  Future makeSale(List<CartItem> cartItems, double total) async {
    Sale sale;
    String saleId = "1";
    List<PaymentMethod> paymentMethods = [];
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
    paymentMethods.add(PaymentMethod(saleid: saleId, method_type: "Cash", amount: total));
    sale = Sale(
        id: saleId,
        user_id: MySharedPref.getUserId(),
        customer_id: "1",
        currency: "USD",
        amount: total,
        product: products,
        paymentMethods: paymentMethods);

    try {
      isMakingSale = true;
      notifyListeners();
      var data = sale.toJson();
      Response response = await Apis.dio.post('sales',
      data: data,
          options: Options(
              headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()}));
      if (response.statusCode == 200) {
        isMakingSale = false;
        notifyListeners();
      } else {
        ///error
      }
    } catch (e) {
      print('Error  is $e');
    } finally {
      isMakingSale = false;
      notifyListeners();
    }
  }
}
