import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/home_provider.dart';
import 'package:grocery_app/model/login.dart';
import 'package:grocery_app/screens/home_dashboad_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/button.dart';
import 'package:grocery_app/widgets/customs/custome_icon.dart';
import 'package:provider/provider.dart';

class SelectOutlet extends StatelessWidget {
  const SelectOutlet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              CustomIconButton(
                onPressed: () => Navigator.pop(context),
                backgroundColor: scaffoldBackgroundColor,
                borderColor: dividerColor,
                icon: SvgPicture.asset(
                  Constants.backArrowIcon,
                  fit: BoxFit.none,
                  color: cardColor,
                ),
              ),
              SizedBox(height: 35),
              Text(
                "Let's get started",
                style: TextStyle(color: greyColor, fontSize: 28, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text(
                "Select your current store ${args['outlets'].length}",
                style: TextStyle(color: greyColor, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 90),
              Consumer<LoginController>(builder: (context, provider, child) {
                return provider.isGettingOutlets == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => outletCard(
                          args['outlets'][index].name,
                          args['outlets'][index].building,
                          args['outlets'][index].image,
                          () {
                            
                            provider.updateUi(index);
                            MySharedPref.setOutletId(args['outlets'][index].id.toString());
                          },
                          index,
                          context,
                          provider,
                        ),
                        itemCount: args['outlets'].length,
                      );
              }),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomButton(
            text: 'Proceed',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Consumer<HomeProvider>(
                      builder: (context,provider,child) {
                        return HomeDashBoardScreen(provider:provider);
                      }
                    ),
                    settings: RouteSettings(arguments: args))),
            borderColor: shrineGreen400,
            backgroundColor: primaryColor,
          ),
        ),
      ),
    );
  }
}

Widget outletCard(String title, String subtitle, String svgPath, VoidCallback callback, int index,
    BuildContext context, provider) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25),
    child: SizedBox(
      height: 120,
      width: double.infinity,
      child: ListTile(
        onTap: callback,
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: provider.selectedIndex == index ? primaryColor : cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Center(
            child: Image.memory(base64Decode(svgPath)),
          ),
        ),
        title: Text(
          title,
          style: provider.selectedIndex != index
              ? TextStyle(color: cardColor, fontSize: 18, fontWeight: FontWeight.w600)
              : TextStyle(color: greyColor, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: provider.selectedIndex != index
              ? TextStyle(color: cardColor, fontSize: 18, fontWeight: FontWeight.w600)
              : TextStyle(color: greyColor, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
