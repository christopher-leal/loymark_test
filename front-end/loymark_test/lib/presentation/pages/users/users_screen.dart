import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/core/utils/utils.dart';
import 'package:loymark_test/presentation/pages/users/user_history_cubit.dart';
import 'package:loymark_test/presentation/pages/users/user_screen.dart';
import 'package:loymark_test/presentation/pages/users/users_cubit.dart';
import 'package:loymark_test/presentation/widgets/user_data_search.dart';
import 'package:loymark_test/presentation/widgets/user_list_item.dart';

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
    final userCubit = context.read<UsersCubit>();
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      if (!userCubit.isAllData) userCubit.getUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _dismissConfirm(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('¿Deseas eliminar este usuario?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FlatButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Borrar')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHistoryCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Usuarios'),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final selectedUser = await showSearch(
                      context: context,
                      delegate: UsersDataSearch(BlocProvider.of<UserHistoryCubit>(context)),
                    );
                    if (selectedUser != null) {
                      context.read<UserHistoryCubit>().addToHistory(selectedUser);
                      Utils.navigateTo(context, UserScreen(user: selectedUser));
                    }
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
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
                  return Dismissible(
                    key: ValueKey(user.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<UsersCubit>().deleteUser(user.id);
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      return await _dismissConfirm(context);
                    },
                    child: UserListItem(
                      user: user,
                      onTap: () {
                        Utils.navigateTo(context, UserScreen(user: user));
                      },
                    ),
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
      ),
    );
  }
}
