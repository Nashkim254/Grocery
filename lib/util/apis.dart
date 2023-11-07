import 'package:dio/dio.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/util/logs.dart';


class Apis {

  //App production
  static bool appProduction = false;

  //staging server url
  static String stagingBaseUrl = Constants.baseUrl;

  //live server url
  static String liveBaseUrl = Constants.baseUrl;

  static String baseUrl = stagingBaseUrl;

  static int connectTimeout = 80*1000;
  static int receiveTimeout = 80*1000;

  static String sentryDns = "";

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: Apis.baseUrl,
      connectTimeout: Duration(milliseconds: Apis.connectTimeout),
      receiveTimeout: Duration(milliseconds: Apis.receiveTimeout),
    ),
  )..interceptors.add(Logs());

}