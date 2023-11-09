import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/screens/welcome.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => WelcomeView())));
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: primaryColorLight,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: primaryColorDark,
              child: Image.asset(Constants.logo, width: 67, height: 55),
            )
                .animate()
                .fade()
                .slideY(duration: Duration(milliseconds: 500), begin: 1, curve: Curves.easeInSine),
            SizedBox(
              width: 20,
            ),
            Text('Right from\nFarmers',
                    style: theme.textTheme.bodyMedium!.copyWith(fontSize: 28,color: shrineBackgroundWhite)).animate().fade().slideX(
                  duration: 300.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
