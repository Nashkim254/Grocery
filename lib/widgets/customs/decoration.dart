import 'package:flutter/material.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
InputDecoration decorationWidget(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14, color: kTextLightColor),
    filled: true,
    fillColor: cardColor,
    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:  BorderSide(
        color: cardColor,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:  BorderSide(
        color: cardColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:  BorderSide(
        color: cardColor,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:  BorderSide(
        color: cardColor,
        width: 4,
      ),
    ),
  );
}
