
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
           Constants.backgroundDark,
              fit: BoxFit.fill,
              // color: backgroundColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 95),
                CircleAvatar(
                  radius: 33,
                  backgroundColor: primaryColorDark,
                  child: Image.asset(
                    Constants.logo,
                    width: 40.33, height: 33.40,
                  ),
                ).animate().fade().slideY(
                  duration: 300.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
                 SizedBox(height: 30),
                Text(
                  'Get your groceries delivered to your home',
                  style: theme.textTheme.displayMedium!.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                  duration: 300.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
                 SizedBox(height: 24),
                Text(
                  'The best delivery app in town for delivering your daily fresh groceries',
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                  duration: 300.ms,
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
                 SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: CustomButton(
                    text: 'Shop now',
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginUI())),
                    fontSize: 16,
                    radius: 50,
                    verticalPadding: 16,
                    hasShadow: false,
                    backgroundColor: primaryColor,
                  ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
