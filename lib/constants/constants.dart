class Constants {
  static const baseUrl = 'http://127.0.0.1:8000/api';
  static const logo = 'shopping_assets/images/logo/app_icon.png';
  static const backgroundDark = 'shopping_assets/images/fruits/background_dark.png';
  static const backArrowIcon = 'shopping_assets/svg/back_arrow.svg';
  static const searchIcon = 'shopping_assets/icons/search1.svg';
  static const avatar = 'shopping_assets/images/avatar.png';

  static String greeting(context) {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good moring";
    }
    if (hour < 17) {
      return "Good afternoon";
    }
    return "Good evening";
  }
}
emailValidator(String value) {
  if (value.isEmpty) {
    return "Please Enter Email";
  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
    return "Please Enter a Valid Email";
  }
  return null;
}

//empty string validator
emptyValidator(String value) {
  if (value.isEmpty) {
    return "Field is empty";
  }
  return null;
}

//validate phone number
validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

//pass string validator
passValidator(String value) {
  if (value.isEmpty) {
    return "Field is empty";
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}
