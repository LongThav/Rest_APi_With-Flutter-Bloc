import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/constants/snack_bar.dart';
import 'package:project/views/home_view.dart';

import '../db_helper/cache_token.dart';
import '../service/auth_service.dart';

abstract class AuthState{}

class InitializeState extends AuthState{}
class LoginLoadingState extends AuthState{
  bool isLoading;
  LoginLoadingState({required this.isLoading});
}

class SignUpLoadingState extends AuthState{
  bool isLoading;
  SignUpLoadingState({required this.isLoading});
}

class AuthLogic extends Cubit<AuthState>{
  final AuthService _authService;
  final CacheToken _cacheToken;
  AuthLogic(this._authService, this._cacheToken) : super(InitializeState());

  Future loginLogic(String email, String password, BuildContext context)async{
    emit(LoginLoadingState(isLoading: true));
    final Map<String,dynamic> data = {
      'email': email,
      'password': password
    };
    await _authService.loginService(data).then((value){
      emit(LoginLoadingState(isLoading: false));
      _cacheToken.writeToken(value.token);
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );
      snackBar(context, "Login successfully!");
    }).onError((error, stackTrace){
      emit(LoginLoadingState(isLoading: false));
      snackBar(context, "Login failed");
    });
  }

  Future createAccountLogic(String email, String password, String name, BuildContext context)async{
    emit(SignUpLoadingState(isLoading: true));
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name
    };
    await _authService.createAccountService(data).then((value){
      emit(SignUpLoadingState(isLoading: false));
      snackBar(context, "Account create successfully!");
    }).onError((error, stackTrace){
      emit(SignUpLoadingState(isLoading: false));
    });
  }
}