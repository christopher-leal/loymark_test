import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/presentation/pages/users/users_cubit.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    context.read<UsersCubit>().getUsers();
    _scrollController.addListener(onListen);
    super.initState();
  }

  void onListen() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      context.read<UsersCubit>().getUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state.users.isEmpty && state.isLoading) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.users.length + 1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index < state.users.length) {
                final user = state.users[index];
                return ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(user.name),
                  onTap: () {},
                );
              } else if (context.read<UsersCubit>().isAllData) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        'No hay más información para mostrar',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ));
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
