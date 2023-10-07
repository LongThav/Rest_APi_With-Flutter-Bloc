import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../views/login_view.dart';

class CacheToken {
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  String token = "token";
  String noToken = "noToken";

  void writeToken(String value) {
    _flutterSecureStorage.write(key: token, value: value);
  }

  Future<String> readToken() async {
    String? tokenUser = await _flutterSecureStorage.read(key: token);
    return tokenUser ?? noToken;
  }

  void delelteAll(BuildContext context) {
    _flutterSecureStorage.deleteAll().then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    });
  }
}
