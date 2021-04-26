import 'package:flutter/material.dart';
import 'package:loymark_test/domain/entities/user.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({Key key, @required this.user, @required this.onTap}) : super(key: key);
  final User user;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('ID: ${user.id}'),
      title: Text(user.fullName),
      subtitle: Text(user.email),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
