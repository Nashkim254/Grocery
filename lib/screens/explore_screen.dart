import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/custom_searchfield.dart';
import 'package:grocery_app/widgets/explore/product_widget.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  final List<Product>? categoryProducts;

  const ExploreScreen({Key? key, this.categoryProducts}) : super(key: key);
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Product>? _products;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    Provider.of<Products>(context, listen: false).getProducts(MySharedPref.getOutletId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categoryProducts == null || widget.categoryProducts!.isEmpty) {
      _products = Provider.of<Products>(context).items;
    } else {
      _products = widget.categoryProducts;
    }
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: !Responsive.isMobile(context) ? SizedBox() : NavDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
           IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: shrineBackgroundWhite,)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Favourites",
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
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              itemBuilder: (_, index) {
                Product product = _products![index];
                return ChangeNotifierProvider.value(
                  value: product,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                        return ProductDetailsScreen(product: product);
                      }));
                    },
                    child: ProductWidget(),
                  ),
                );
              },
              itemCount: _products!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.getCrossAxisCount(context),
                // childAspectRatio: 200 / 220,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
