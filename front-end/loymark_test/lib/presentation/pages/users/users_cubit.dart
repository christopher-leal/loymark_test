import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/usecases/delete_user_usecase.dart';
import 'package:loymark_test/domain/usecases/get_users_usecase.dart';

class UsersState {
  UsersState(this.users, {this.isLoading = false});
  final List<User> users;
  final bool isLoading;
}

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._getUsersUseCase, this._deleteUserUseCase) : super(UsersState([]));
  final GetUsersUseCase _getUsersUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  int totalItems = 0;
  int offset = 0;

  bool get isAllData => totalItems == state.users.length;

  Future<void> getUsers() async {
    emit(UsersState([...state.users], isLoading: true));
    final data = await _getUsersUseCase.getUsers(offset);
    totalItems = data.totalItems;
    emit(UsersState([...state.users, ...data.items]));
    offset += 20;
  }

  Future<void> deleteUser(int id) async {
    final success = await _deleteUserUseCase.deleteUser(id);
    if (success) {
      state.users.removeWhere((user) => user.id == id);
      totalItems -= 1;

      emit(UsersState(state.users));
    }
  }
}
