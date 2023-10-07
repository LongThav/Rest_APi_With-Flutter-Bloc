import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/db_helper/cache_token.dart';
import 'package:project/service/auth_service.dart';
import 'package:project/service/service.dart';
import 'package:project/views/splash_view.dart';


import 'logice/auth_logic.dart';
import 'logice/logic.dart';

void main() {
  RestAPIService service = RestAPIService();
  AuthService authService = AuthService();
  CacheToken cacheToken = CacheToken();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthLogic(authService, cacheToken)),
        BlocProvider<LogicalService>(create: (context) => LogicalService(service)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      )));
}
