import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/data/repositories/user_service.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';
import 'package:loymark_test/domain/usecases/delete_user_usecase.dart';
import 'package:loymark_test/domain/usecases/get_users_usecase.dart';

List<RepositoryProvider> buildRepositories = [
  // repositories
  RepositoryProvider<UsersRepository>(create: (context) => UserService()),
  // usecases
  RepositoryProvider<GetUsersUseCase>(create: (context) => GetUsersUseCase(context.read())),
  RepositoryProvider<DeleteUserUseCase>(create: (context) => DeleteUserUseCase(context.read())),
];
