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
