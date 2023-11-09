import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/home_provider.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/screens/cart_screen.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/screens/fav_screen.dart';
import 'package:grocery_app/screens/shop_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';

class HomeDashBoardScreen extends StatefulWidget {
 final HomeProvider  provider;
  const HomeDashBoardScreen({
    Key? key,
    required this.provider,
  }) : super(key: key);
  @override
  _HomeDashBoardScreenState createState() => _HomeDashBoardScreenState();
}

class _HomeDashBoardScreenState extends State<HomeDashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  List<Product> _categoryProducts = [];
  
  @override
  void initState() {
    Provider.of<Categories>(context,listen: false).getCategories(MySharedPref.getOutletId());
    super.initState();
  }

  Widget navigateToScreen() {
    switch (widget.provider.currentIndex) {
      case 1:
        return ExploreScreen(
          categoryProducts: _categoryProducts,
        );
      case 2:
        return CartScreen();
      case 3:
        return FavScreen();
      case 0:
      default:
        return ShopScreen(
          // categoryClick: (int categoryId) async{
          //     _categoryProducts = await 
          //         Provider.of<Categories>(context).getProducts(categoryId.toString(), MySharedPref.getOutletId());
          //     _currentIndex = 1; 
          // },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: scaffoldBackgroundColor,
      drawer: !Responsive.isMobile(context) ? SizedBox() : NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: shrineGreen400,
        foregroundColor: Colors.white,
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: shrineGreen100,
            selectedItemColor: shrineGreen400,
            currentIndex: provider.currentIndex,
            backgroundColor: scaffoldBackgroundColor,
            // selectedItemColor: colorScheme.onSurface,
            // unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
            // selectedLabelStyle: textTheme.caption,
            // unselectedLabelStyle: textTheme.caption,
            onTap: (value) {
              // Respond to item press.
             provider.switchIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Shop',
                icon: Icon(Icons.shopping_bag),
                backgroundColor: scaffoldBackgroundColor,
              ),
              BottomNavigationBarItem(
                label: 'Explore',
                icon: Icon(Icons.search),
                backgroundColor: scaffoldBackgroundColor,
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(Icons.shopping_cart),
                backgroundColor: scaffoldBackgroundColor,
              ),
              BottomNavigationBarItem(
                label: 'Favourite',
                icon: Icon(Icons.favorite),
                backgroundColor: scaffoldBackgroundColor,
              ),
            ],
          );
        }
      ),
      body: navigateToScreen(),
    );
  }
}
