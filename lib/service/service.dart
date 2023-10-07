import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project/model/login_model.dart';
import 'package:project/model/user_model.dart';

class RestAPIService {
  Future<bool> addUserService(String email, String username) async {
    try {
      final Map<String, dynamic> map = {
        "username": username,
        "email": email
      };
      http.Response response = await http.post(Uri.parse("http://10.0.2.2:8000/api/add-user"), body: map);
      debugPrint("Response body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  UserModel _userModel = UserModel();

  Future<UserModel> readUserService() async {
    try {
      http.Response response = await http.get(Uri.parse("http://10.0.2.2:8000/api/all-user"));
      if (response.statusCode == 200) {
        _userModel = await compute(_pareJson, response.body);
      }
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
    return _userModel;
  }

  Future<bool> updateUserService(dynamic data) async {
    try {
      http.Response response = await http.put(Uri.parse("http://10.0.2.2:8000/api/update-user"), body: data);
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> deleteUserSerice(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse("http://10.0.2.2:8000/api/delete-user"), body: {
        "id": id
      });
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      debugPrint("error: $err");
      throw Exception(err);
    }
  }


  String urlLogin = "http://10.0.2.2:8000/api/login";
  String urlSignUp = "http://10.0.2.2:8000/api/register";

}

UserModel _pareJson(String json) => UserModel.fromJson(jsonDecode(json));
