import 'package:loymark_test/domain/repositories/users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);
  final UsersRepository _repository;

  Future<bool> deleteUser(int id) async {
    return await _repository.deleteUser(id);
  }
}
