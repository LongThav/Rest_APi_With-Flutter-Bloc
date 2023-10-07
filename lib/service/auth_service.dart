import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project/model/login_model.dart';

class AuthService {
  String urlLogin = "http://10.0.2.2:8000/api/login";
  String urlSignUp = "http://10.0.2.2:8000/api/register";

  LoginModel loginModel = LoginModel(user: User());

  Future<LoginModel> loginService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(urlLogin),
        body: data,
      );
      if (response.statusCode == 200) {
        loginModel = await compute(_pareJsonLogin, response.body);
      }
      return loginModel;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> createAccountService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(urlSignUp),
        body: data,
      );
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}

LoginModel _pareJsonLogin(String json) => LoginModel.fromJson(jsonDecode(json));
