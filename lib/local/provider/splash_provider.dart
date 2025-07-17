import 'package:expense_tracker/local/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  bool _isNew = false;

  bool get isNew => _isNew;

  set isNew(bool value) {
    _isNew = value;
    notifyListeners();
  }

  void checkPreference() async {
    final sharedPreference = await SharedPreferences.getInstance();
    var temp = sharedPreference.getBool(isNewUser);
    if (temp != null) {
      isNew = temp;
    }
  }

  void initializePreference() async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool(isNewUser, true);
  }
}
