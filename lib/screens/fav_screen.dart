import 'package:flutter/material.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/fav/FavWidget.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).favoriteItems;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Favourites",
                style: theme.textTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.normal, color: kTextLightColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, i) => FavWidget(
                  product: products[i],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
