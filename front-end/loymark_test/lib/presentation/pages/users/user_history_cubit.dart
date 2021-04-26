import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/usecases/get_users_usecase.dart';

class UserHistoryState {
  UserHistoryState({this.users = const [], this.history = const [], this.isLoading = false});
  final List<User> users;
  final List<User> history;
  final bool isLoading;
}

class UserHistoryCubit extends Cubit<UserHistoryState> {
  UserHistoryCubit(this._useCase) : super(UserHistoryState());
  final GetUsersUseCase _useCase;

  void addToHistory(User user) {
    if (!state.history.contains(user)) {
      state.history.add(user);
      emit(UserHistoryState(users: [...state.users], history: state.history));
    }
  }

  Future<void> searchClients(String find) async {
    emit(UserHistoryState(users: [], history: [...state.history], isLoading: true));
    final users = await _useCase.searchUsers(find);
    emit(UserHistoryState(users: users, history: [...state.history]));
  }
}
