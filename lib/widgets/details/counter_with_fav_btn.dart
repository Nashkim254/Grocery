import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/model/fav.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  final Product product;
  const CounterWithFavBtn({Key? key, required this.product}) : super(key: key);

  void addProductToFav(BuildContext context, Product product, Fav fav) {
    fav.addItem(product.id, product.price, product.title, product.imageUrl);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added item to favorite!',
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            fav.removeSingleItem(product.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Consumer<Fav>(
          builder: (context,provider,child) {
            return InkWell(
              onTap:()=> addProductToFav(context, product,provider),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: shrineGreen400,
                  shape: BoxShape.circle,
                ),
                child: Center(child: SvgPicture.asset("shopping_assets/icons/heart.svg")),
              ),
            );
          }
        )
      ],
    );
  }
}
