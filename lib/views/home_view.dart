import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/logice/logice.dart';
import 'package:project/model/user_model.dart';
import 'package:project/views/add_user_view.dart';
import 'package:project/views/update_user_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<LogicalService>().add(ReadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Display User"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserView()));
          Future.delayed(const Duration(milliseconds: 500), () {
            context.read<LogicalService>().add(ReadUserEvent());
          });
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<LogicalService, LogicState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadUserState) {
        var data = state.userModel;
        return _buildListview(data);
      } else {
        return Container();
      }
    });
  }

  Widget _buildListview(UserModel userModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LogicalService>().add(ReadUserEvent());
      },
      child: ListView.builder(
          itemCount: userModel.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpDateUserView(
                      id: userModel.data[index].id,
                      username: userModel.data[index].username,
                      email: userModel.data[index].email);
                }));
              },
              child: ListTile(
                leading: Text(userModel.data[index].id.toString()),
                title: Text("Name: ${userModel.data[index].username}"),
                subtitle: Text("Email: ${userModel.data[index].email}"),
                trailing: IconButton(
                    onPressed: () {
                      context.read<LogicalService>().add(DeleteUserEvent(
                          id: userModel.data[index].id.toString()));
                      context.read<LogicalService>().add(ReadUserEvent());
                    },
                    icon: const Icon(Icons.delete_outline)),
              ),
            );
          }),
    );
  }
}
