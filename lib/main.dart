import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/service/service.dart';
import 'package:project/views/splash_view.dart';

import 'logice/logice.dart';

void main() {
  RestAPIService service = RestAPIService();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LogicalService>(create: (context) => LogicalService(service)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      )));
}
