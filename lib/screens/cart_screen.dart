import 'package:flutter/material.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/orders.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/cart/cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: scaffoldBackgroundColor,
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(16),
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20, color: kTextLightColor),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        'Ksh ${cart.totalAmount.toStringAsFixed(2)}',
                      ),
                      backgroundColor: shrineGreen400,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                          context
                        );
                        cart.clear();
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(shrineGreen400),
                      ),
                      child: Text('ORDER NOW'),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartWidget(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].imageUrl,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
