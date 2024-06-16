import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maidstest/API%20service/Signinservice.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:maidstest/screen/TaskScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/UserModel.dart';

class UserProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  User? _user;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _isSplashLoading = true;
  bool hidepassword = true;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isSplashLoading => _isSplashLoading;

  Future<void> login(BuildContext ctx, String username, String password) async {
    final SigninApiService apiService = SigninApiService();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isLoading = true;
    notifyListeners();

    try {
      User user = await apiService.login(username, password);
      Navigator.of(ctx).pushNamed(TodosPage.screenRoute);
      _user = user;

      prefs.setString('user', jsonEncode(user.toJson()));
      prefs.setBool('loginstat', true);

      _isLoggedIn = true;
    } catch (error) {
      Alert(
        style: AlertStyle(
          isOverlayTapDismiss: false,
          alertBorder: Border.all(
            color: Tcolor.maincolor,
          ),
        ),
        context: ctx,
        title: 'Sorry',
        content: Text(error.toString()),
        buttons: [
          DialogButton(
            color: Tcolor.maincolor,
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user');
    final bool? loginstat = prefs.getBool('loginstat');

    if (userData != null && loginstat == true) {
      _user = User.fromJson(jsonDecode(userData));
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }

    _isSplashLoading = false;
    notifyListeners();
  }

  notifyListeners();
}
