import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int currentIndex = 0;

  switchIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
