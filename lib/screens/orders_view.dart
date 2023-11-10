import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/custom_searchfield.dart';
import 'package:provider/provider.dart';

import '../model/orders.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    // String endDate = 
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().subtract(Duration(days: 1));
    Provider.of<Orders>(context, listen: false).getSales(context, startDate, endDate);
    super.initState();
  }

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
                  hint: 'Search orders',
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
              const SizedBox(
                height: 20,
              ),
              Consumer<Orders>(builder: (context, provider, child) {
                return provider.isGettingSale == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : provider.sales.isEmpty
                        ? Center(
                            child: Text('You have no orders at the moment'),
                          )
                        : SizedBox(
                          height: MediaQuery.of(context).size.height * 3/4,
                          child: ListView.separated(
                              itemBuilder: (context, int index) {
                                return Card(
                                  color: cardColor,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    leading: Text(index.toString()),
                                    title: Text(
                                      provider.sales[index].id,
                                      style: TextStyle(color: kTextLightColor),
                                    ),
                                    subtitle: Text(
                                      "Total: Ksh ${provider.sales[index].currency} ${provider.sales[index].total_amount}",
                                      style: TextStyle(color: kTextLightColor),
                                    ),
                                    trailing: Text(
                                      'Successful',
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, int index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: provider.sales.length),
                        );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
