import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_app/model/login.dart';
import 'package:grocery_app/screens/register.dart';
import 'package:grocery_app/util/logs.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/login/wave_clipper.dart';
import 'package:provider/provider.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget _loginPanel(double w, double h) {
    final controller = Provider.of<LoginController>(context);
    return ListView(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 20),
          child: Form(
            //   key: formkey,
            child: TextFormField(
              controller: phone,
              cursorColor: shrineBackgroundWhite,
              style: TextStyle(color: shrineBackgroundWhite, fontSize: 18, fontWeight: FontWeight.w400),
              keyboardType: TextInputType.text,
              obscureText: false,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Phone",
                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                hintStyle: TextStyle(color: shrineBackgroundWhite, fontWeight: FontWeight.w600),
              ),
              onChanged: ((value) => printWarning(value)),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 20),
          child: Form(
            //   key: formkey,
            child: TextFormField(
              controller: password,
              cursorColor: shrineBackgroundWhite,
              style: TextStyle(color: shrineBackgroundWhite, fontSize: 18, fontWeight: FontWeight.w400),
              keyboardType: TextInputType.text,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Password",
                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                hintStyle: TextStyle(color: shrineBackgroundWhite, fontWeight: FontWeight.w600),
              ),
              onChanged: ((value) => printWarning(value)),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: h / 20, left: 25, right: 25, bottom: 25),
          child: Consumer<LoginController>(builder: (context, provider, child) {
            return InkWell(
              onTap: provider.isDataLoading == true
                  ? () {}
                  : () {
                      controller.login(phone.text, password.text, context);
                      // _positionController.forward();
                    },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: provider.isDataLoading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            );
          }),
        ),
        // _facebookButton('f', shrineGreen400, 'Log in with Facebook',
        //     shrineGreen300),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Don\'nt have an account? ',
                  style: TextStyle(fontSize: 16, color: shrineBackgroundWhite),
                ),
                TextSpan(
                  text: "Register",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Register())),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 40),
            //     margin: EdgeInsets.only(top:h/15),
            height: h / 1.2,
            width: w,
            child: ClipPath(
              clipper: WaveClipper(),
              child: ColoredBox(
                color: primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: h / 7, left: w / 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Welcome\nHere ",
                  style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w600),
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ],
            ),
          ),
          Responsive(
            mobile: Container(
              margin: EdgeInsets.only(top: h / 2.5),
              alignment: Alignment.center,
              child: _loginPanel(w, h),
            ),
            tablet: Container(
              margin: EdgeInsets.only(top: h / 2.5, left: w / 4, right: w / 4),
              alignment: Alignment.center,
              child: _loginPanel(w, h),
            ),
            desktop: Container(
              margin: EdgeInsets.only(top: h / 2.5, left: w / 4, right: w / 4),
              alignment: Alignment.center,
              child: _loginPanel(w, h),
            ),
          ),
        ],
      ),
    );
  }
}
