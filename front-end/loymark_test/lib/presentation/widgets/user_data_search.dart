import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/presentation/pages/users/user_history_cubit.dart';
import 'package:loymark_test/presentation/widgets/user_list_item.dart';

class UsersDataSearch extends SearchDelegate<User> {
  UsersDataSearch(this.bloc);
  final UserHistoryCubit bloc;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(child: Text('No has ingresado ninguna busqueda'));
    }
    return BlocBuilder<UserHistoryCubit, UserHistoryState>(
      cubit: bloc..searchClients(query),
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());
        if (state.users.isEmpty) {
          return const Center(
            child: Text('No se encontraron resultados'),
          );
        }
        return _showItems(context, state.users);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<UserHistoryCubit, UserHistoryState>(
      cubit: bloc,
      builder: (context, state) {
        return _showItems(context, state.history);
      },
    );
  }

  Widget _showItems(BuildContext context, List<User> users) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserListItem(
          user: user,
          onTap: () {
            close(context, user);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
