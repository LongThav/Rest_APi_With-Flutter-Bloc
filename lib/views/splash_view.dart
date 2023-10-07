import 'package:flutter/material.dart';
import 'package:project/db_helper/cache_token.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final CacheToken _cacheToken = CacheToken();
  void init() async {
    String token = await _cacheToken.readToken();
    debugPrint("Token User: $token");
    if (token == "noToken") {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
        );
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );
      });
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Splsh View",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
