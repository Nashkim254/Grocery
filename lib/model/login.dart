import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/outlets.dart';
import 'package:grocery_app/screens/home_dashboad_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/select_outlet.dart';
import 'package:grocery_app/sharedprefs/shared_prefs.dart';

class LoginController with ChangeNotifier {
  final dio = Dio();
  bool isDataLoading = false;
  bool isGettingOutlets = false;
  bool isRegistering = false;
  int selectedIndex = 0;
  List<OutletsModel> outlets = [];

  Future login(String phone, String password, context) async {
    debugPrint("hit login");
    debugPrint(Constants.baseUrl + '/login');
    try {
      isDataLoading = true;
      notifyListeners();
      Map body = {"phone": phone, "password": password};
      Response response = await dio.post(Constants.baseUrl + '/login', data: body);
      if (response.statusCode == 200) {
        isDataLoading = false;

        ///data successfully
        MySharedPref.setToken(response.data['token']);
        MySharedPref.setName(response.data['name']);
        MySharedPref.setUserId(response.data['id']);
        var argument = {"name": response.data['name']};
        print(response.data['token']);
        await getOutlet(response.data['id'], argument, context);
      } else {
        ///error
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isDataLoading = false;
    }
    notifyListeners();
  }

  Future getOutlet(String userId, Map args, context) async {
    debugPrint("hit $userId");
    debugPrint("hit ${MySharedPref.getToken()}");
    debugPrint(Constants.baseUrl + '/outlet/$userId');
    try {
      isGettingOutlets = true;
      Response response = await dio.get(Constants.baseUrl + '/outlets/$userId',
          options: Options(
              headers: {'Content-Type': 'application/json', "token": MySharedPref.getToken()}));
      if (response.statusCode == 200) {
        isGettingOutlets = false;

        for (int i = 0; i < response.data.length; i++) {
          outlets.add(OutletsModel(
              name: response.data[i]['name'],
              building: response.data[i]['building'],
              image: response.data[i]['image'],
              id: response.data[i]['id']));
        }
        var outletsMap = {"outlets": outlets};
        args.addEntries(outletsMap.entries);

        ///data successfully
        if (response.data.length == 1) {
          MySharedPref.setOutletId(response.data[0]['id'].toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HomeDashBoardScreen(), settings: RouteSettings(arguments: args)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SelectOutlet(), settings: RouteSettings(arguments: args)));
        }
      } else {
        ///error
      }
    } catch (e) {
      print('Error  is $e');
    } finally {
      isGettingOutlets = false;
    }
  }

  Future register(
      String phone, String password, String fname, String lname, String email, context) async {
    try {
      isRegistering = true;
      Map body = {
        "first_name": fname,
        "last_name": lname,
        "password": password,
        "email": email,
        "phone": phone
      };
      Response response = await dio.post(Constants.baseUrl + '/register', data: body);
      if (response.statusCode == 200) {
        isRegistering = false;
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUI()));
      } else {
        isRegistering = false;

        ///error
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isDataLoading = false;
    }
  }
}
