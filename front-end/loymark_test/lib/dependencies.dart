import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/data/repositories/activities_services.dart';
import 'package:loymark_test/data/repositories/users_service.dart';
import 'package:loymark_test/domain/repositories/activities_repository.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';
import 'package:loymark_test/domain/usecases/delete_user_usecase.dart';
import 'package:loymark_test/domain/usecases/get_countries_usecase.dart';
import 'package:loymark_test/domain/usecases/get_users_usecase.dart';

import 'domain/usecases/get_activities_usecase.dart';
import 'domain/usecases/upsert_user_usecase.dart';

List<RepositoryProvider> buildRepositories = [
  // repositories
  RepositoryProvider<UsersRepository>(create: (context) => UsersService()),
  RepositoryProvider<ActivitiesRepository>(create: (context) => ActivitiesService()),
  // usecases
  RepositoryProvider<GetUsersUseCase>(create: (context) => GetUsersUseCase(context.read())),
  RepositoryProvider<DeleteUserUseCase>(create: (context) => DeleteUserUseCase(context.read())),
  RepositoryProvider<GetActivitiesUseCase>(create: (context) => GetActivitiesUseCase(context.read())),
  RepositoryProvider<UpsertUserUseCase>(create: (context) => UpsertUserUseCase(context.read())),
  RepositoryProvider<GetCountriesUseCase>(create: (context) => GetCountriesUseCase()),
];
