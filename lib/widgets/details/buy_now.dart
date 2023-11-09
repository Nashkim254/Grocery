import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

class BuyNow extends StatelessWidget {
  const BuyNow({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;
  void addProductToCart(BuildContext context, Product product, Cart cart) {
    cart.addItem(product.id, product.price, product.title, product.imageUrl);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added item to cart!',
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            cart.removeSingleItem(product.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final cart = Provider.of<Cart>(context, listen: false);
    return Row(
      children: <Widget>[
        ChangeNotifierProvider.value(
          value: product,
          child: Container(
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: shrineGreen400,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "shopping_assets/icons/add_to_cart.svg",
                color: shrineGreen400,
              ),
              onPressed: () {
                addProductToCart(context, product!, cart);
              },
            ),
          ),
        ),
        Flexible(
          child: Container(
            height: 50,
            width: w * 0.5,
            margin: EdgeInsets.symmetric(horizontal: w * 0.2),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(shrineGreen400),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {},
              child: Text("Buy Now".toUpperCase()),
            ),
          ),
        ),
      ],
    );
  }
}
