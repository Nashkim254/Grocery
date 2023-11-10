import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/model/home_provider.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/custom_searchfield.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';
import 'package:grocery_app/widgets/shop/category_widget.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  // final Function? categoryClick;

  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController editingController = TextEditingController();
  late List<Category> _categories;
  late HomeProvider provider;
  @override
  void initState() {
    Provider.of<Categories>(context, listen: false).getCategories(MySharedPref.getOutletId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _categories = Provider.of<Categories>(context).items;
    provider = Provider.of<HomeProvider>(context);
   final categoryProvider = Provider.of<Categories>(context);
    final theme = Theme.of(context);
    final Map args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: scaffoldBackgroundColor,
        drawer: !Responsive.isMobile(context) ? SizedBox() : NavDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:10),
               IconButton(onPressed: (){
                _scaffoldKey.currentState?.openDrawer();
               }, icon: Icon(Icons.menu,color: shrineBackgroundWhite,)),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24),
                title: Text(
                  Constants.greeting(context),
                  style: theme.textTheme.bodyText2?.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  args['name'],
                  style: theme.textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryColorDark,
                  child: ClipOval(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(Constants.avatar),
                    ),
                  ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (_, index) {
                    Category category = _categories[index];
                    return CategoryWidget(
                      category: category,
                      onTap: (int id) async {
                        print('Product List of Category search id: ' + id.toString());
                        await 
                            categoryProvider.getProducts(id.toString(), MySharedPref.getOutletId())
                            .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=> ExploreScreen(categoryProducts: value,))));
                      },
                    );
                  },
                  itemCount: _categories.length,
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
        ),
      ),
    );
  }
}
