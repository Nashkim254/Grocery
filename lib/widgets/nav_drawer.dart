import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orders_view.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              MySharedPref.getName(),
              style: TextStyle(fontSize: 20, color: kTextLightColor),
            ),
            accountEmail: Text(MySharedPref.getPhone()),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('shopping_assets/nav_drawer_image.png'),
                fit: BoxFit.cover,
                // colorFilter: new ColorFilter.mode(Colors.black, BlendMode.dstATop),
              ),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                'shopping_assets/images/user.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                color: shrineBackgroundWhite,
              ),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "Orders",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrdersView(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(
                Icons.event_note_sharp,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "My Details",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "Shopping",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(
                Icons.settings,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "Settings",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.info,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "About",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: shrineBackgroundWhite,
              ),
              title: new Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: kTextLightColor),
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
