import 'package:flutter/material.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6!.copyWith(color: kTextLightColor),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  Widget buildOutlineButton({IconData? icon, Function? press}) {
    return InkWell(
      onTap: press as void Function()?,
      child: Container(
        width: 40,
        height: 32,
        decoration: BoxDecoration(
        border:  Border.all(color: shrineGreen400),
        borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Icon(
            icon,
            color: shrineGreen400,
          ),
        ),
      ),
    );

  
  }
}
