import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/constants/snack_bar.dart';
import 'package:project/logice/logice.dart';

class UpDateUserView extends StatefulWidget {
  final int id;
  final String username;
  final String email;
  const UpDateUserView(
      {super.key,
      required this.id,
      required this.username,
      required this.email});

  @override
  State<UpDateUserView> createState() => _UpDateUserViewState();
}

class _UpDateUserViewState extends State<UpDateUserView> {
  late final TextEditingController _userNameCtrl;
  late final TextEditingController _email;

  @override
  void initState() {
    _userNameCtrl = TextEditingController(text: widget.username);
    _email = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    _userNameCtrl.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _userNameCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "User Name"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "User email"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (_userNameCtrl.text.isEmpty) {
                snackBar(context, "User name can't null");
              } else if (_email.text.isEmpty) {
                snackBar(context, "Email can't null");
              } else {
                context.read<LogicalService>().add(UpdateUserEvent(
                      context,
                      id: widget.id.toString(),
                      email: _email.text,
                      username: _userNameCtrl.text,
                    ));
                    context.read<LogicalService>().add(ReadUserEvent());
              }
            },
            child: BlocBuilder<LogicalService, LogicState>(
              builder: (context, state) {
                if (state is UpdateUserLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Update User");
                } else {
                  return const Text("Update User");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
