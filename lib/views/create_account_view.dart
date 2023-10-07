import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/constants/snack_bar.dart';
import 'package:project/logice/auth_logic.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _check = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Account"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: "Email"),
            ),
          ),
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
              if (_nameCtrl.text.isEmpty) {
                snackBar(context, "Please input your name");
              } else if (_emailCtrl.text.isEmpty) {
                snackBar(context, "Please input your email");
              } else if (_passwordCtrl.text.isEmpty) {
                snackBar(context, "Please input your password");
              } else {
                debugPrint("Start create account");
                context.read<AuthLogic>().createAccountLogic(
                      _emailCtrl.text,
                      _passwordCtrl.text,
                      _nameCtrl.text,
                      context,
                    );
              }
            },
            child: BlocBuilder<AuthLogic, AuthState>(
              builder: (context, state){
                if(state is SignUpLoadingState){
                  return state.isLoading? const CircularProgressIndicator(color: Colors.white,) : const Text("Login");
                }else{
                  return const Text("Login");
                }
              }
            )
          )
        ],
      ),
    );
  }
}
