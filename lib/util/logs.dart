import 'package:dio/dio.dart';
import 'package:grocery_app/util/apis.dart';

class Logs extends Interceptor {
  /// TODO ADD SENTRY TO LOGS

  //When ever a request is made
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///
    printInfo('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  //When ever a response is received
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printSuccess(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  //When ever an error occurs
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError(
      'ERROR : [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
  ///------------------------------------
  /// Print to console in red
  ///------------------------------------
  printError(text, {name = '📕: error'}) => _log('\x1B[31m --- $text --- \x1B[0m', name);

  ///------------------------------------
  /// Print to console in green
  ///------------------------------------
  printSuccess(text, {name = '📙: success'}) => _log('\x1B[32m --- $text --- \x1B[0m', name);

  ///------------------------------------
  /// Print to console in yellow
  ///------------------------------------
  printWarning(text, {name = '📗: warning'}) => _log('\x1B[33m --- $text --- \x1B[0m', name);

  ///------------------------------------
  /// Print to console in blue
  ///------------------------------------
  printInfo(text, {name = '📘: info'}) => _log('\x1B[34m --- $text --- \x1B[0m', name);

  ///------------------------------------
  /// Print to console in white
  ///------------------------------------
  printNormal(text, {name = '📓: normal'}) => _log('\x1B[37m --- $text --- \x1B[0m', name);


  _log(body, name){
    return Apis.appProduction ? "?" :
    print('\x1B[31m$body\x1B[0m');
  }



