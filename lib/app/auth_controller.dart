import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/models/user_model.dart';

class AuthController {
  static const String _tokenKey = 'token';
  static const String _userModelKey = 'user-data';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel userModel, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userModelKey,
      jsonEncode(userModel.toJson()),
    );
    await sharedPreferences.setString(_tokenKey, token);
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userModelKey);

    if (token != null && userData != null) {
      accessToken = token;
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }
}
