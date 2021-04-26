import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/usecases/get_users_usecase.dart';

class UsersState {
  UsersState(this.users, {this.isLoading = false});
  final List<User> users;
  final bool isLoading;
}

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._getUsersUseCase) : super(UsersState([]));
  final GetUsersUseCase _getUsersUseCase;
  int totalItems = 0;
  int offset = 0;
  Future<void> getUsers() async {
    emit(UsersState([...state.users], isLoading: true));
    final data = await _getUsersUseCase.getUsers(offset);
    totalItems = data.totalItems;
    emit(UsersState([...state.users, ...data.items]));
    offset += 20;
  }

  bool get isAllData => totalItems == state.users.length;
}
