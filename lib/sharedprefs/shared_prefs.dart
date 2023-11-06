import 'package:shared_preferences/shared_preferences.dart';
class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _token = 'token';
  static const String _name = 'name';
  static const String _userId = 'userId';
  static const String _outletId = 'outletId';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);
      
        /// set token
  static Future<void> setToken(String token) =>
      _sharedPreferences.setString(_token, token);  
            /// set name
  static Future<void> setName(String name) =>
      _sharedPreferences.setString(_userId, name);

        static Future<void> setUserId(String id) =>
      _sharedPreferences.setString(_userId, id);


        static Future<void> setOutletId(String id) =>
      _sharedPreferences.setString(_outletId, id);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? true;
         /// get token
  static String getToken() =>
      _sharedPreferences.getString(_token) ?? "";
      
        static String getOutletId() =>
      _sharedPreferences.getString(_outletId) ?? "";
                /// get name
  static String getName() =>
      _sharedPreferences.getString(_name) ?? ""; 
      
       static String getUserId() =>
      _sharedPreferences.getString(_userId) ?? ""; 
      
      // todo set the default theme (true for light, false for dark)

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(_currentLocalKey, languageCode);



  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() =>
      _sharedPreferences.getString(_fcmTokenKey);

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();

}