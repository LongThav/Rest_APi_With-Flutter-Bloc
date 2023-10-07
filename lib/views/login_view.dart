import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/constants/snack_bar.dart';
import 'package:project/views/create_account_view.dart';

import '../logice/auth_logic.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _check = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: "Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              obscureText: _check,
              obscuringCharacter: '*',
              controller: _passwordCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: _check ? const Icon(Icons.lock) : const Icon(Icons.key_off),
                    onPressed: () {
                      setState(() {
                        _check = !_check;
                      });
                    },
                  )),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(_emailCtrl.text.isEmpty){
                snackBar(context, "Please input your email");
              }else if(_passwordCtrl.text.isEmpty){
                snackBar(context, "Please input your password");
              }else{
                context.read<AuthLogic>().loginLogic(_emailCtrl.text, _passwordCtrl.text, context);
              }
            },
            child: BlocBuilder<AuthLogic, AuthState>(
              builder: (context, state){
                if(state is LoginLoadingState){
                  return state.isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("Login");
                }else{
                  return const Text("Login");
                }
              }
            )
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountView()));
              },
              child: const Text("Create Account?"))
        ],
      ),
    );
  }
}
