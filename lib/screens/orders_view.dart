import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/custom_searchfield.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Orders",
                  style: theme.textTheme.headline5
                      ?.copyWith(fontWeight: FontWeight.normal, color: kTextLightColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomFormField(
                  backgroundColor: primaryColorDark,
                  textSize: 14,
                  hint: 'Search category',
                  hintFontSize: 14,
                  hintColor: hintTextColor,
                  maxLines: 1,
                  borderRound: 60,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorderColor: Colors.transparent,
                  isSearchField: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  prefixIcon: SvgPicture.asset(Constants.searchIcon, fit: BoxFit.none),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
