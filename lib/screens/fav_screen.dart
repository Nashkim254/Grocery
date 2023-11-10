import 'package:flutter/material.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/fav/FavWidget.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
        backgroundColor: scaffoldBackgroundColor,
        drawer: !Responsive.isMobile(context) ? SizedBox() : NavDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            IconButton(onPressed: (){ _scaffoldKey.currentState?.openDrawer();}, icon: Icon(Icons.menu,color: shrineBackgroundWhite,)),
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
