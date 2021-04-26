import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';

class UpsertUserUseCase {
  UpsertUserUseCase(this._repository);
  final UsersRepository _repository;

  Future<bool> upsertUser(User user) async {
    return await _repository.upsertUser(user);
  }
}
