import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/login.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/customs/button.dart';
import 'package:grocery_app/widgets/customs/custome_icon.dart';
import 'package:grocery_app/widgets/customs/decoration.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
   Register({Key? key}) : super(key: key);

 final GlobalKey  _formKey = GlobalKey<FormState>();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomIconButton(
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: scaffoldBackgroundColor,
                        borderColor: dividerColor,
                        icon: SvgPicture.asset(
                          Constants.backArrowIcon,
                          fit: BoxFit.none,
                          color: shrineBackgroundWhite,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 16, color: kTextLightColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Text(
                    'FirstName',
                    style: TextStyle(fontSize: 14, color: kTextLightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: fnameController,
                    validator: (value) => emptyValidator(value!),
                    style: TextStyle(fontSize: 12, color: kTextLightColor),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    cursorColor: primaryColor,
                    decoration: decorationWidget('Enter your first name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'LastName',
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lnameController,
                    validator: (value) => emptyValidator(value!),
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    cursorColor: primaryColor,
                    decoration: decorationWidget('Enter your last name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailCont,
                    validator: (value) => emptyValidator(value!),
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    cursorColor: primaryColor,
                    decoration: decorationWidget('Enter your phone number'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneCont,
                    validator: (value) => emailValidator(value!),
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    cursorColor: primaryColor,
                    decoration: decorationWidget('Enter your email address'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passCont,
                    validator: (value) => passValidator(value!),
                    style: TextStyle(fontSize: 16, color: kTextLightColor),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    cursorColor: primaryColor,
                    decoration: decorationWidget('Enter your password'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Consumer<LoginController>(builder: (context, provider, child) {
                    return CustomButton(
                      text:
                          provider.isRegistering == true ? "Registering.." : 'Register',
                      onPressed: provider.isRegistering
                          ? () {}
                          : () async {
                              await provider.register(
                                  phoneCont.text,
                                  passCont.text,
                                  fnameController.text,
                                  lnameController.text,
                                  emailCont.text,
                                  context);
                            },
                      backgroundColor: primaryColor,
                      borderColor: primaryColor,
                    );
                  }),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
