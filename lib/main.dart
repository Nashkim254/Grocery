import 'package:flutter/material.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/login.dart';
import 'package:grocery_app/model/orders.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/shopping_theme.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await MySharedPref.init();
    runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ), 
        
         ChangeNotifierProvider.value(
          value: LoginController(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: buildShrineTheme(),
          home: SplashView(),
          routes: {
            // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            // CartScreen.routeName: (ctx) => CartScreen(),
            // OrdersScreen.routeName: (ctx) => OrdersScreen(),
            // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            // EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
