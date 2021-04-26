import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._repository);
  final UsersRepository _repository;

  Future<ApiListResponse<User>> getUsers(int offset) async {
    return await _repository.getUsers(offset);
  }

  Future<ApiListResponse<User>> searchUsers(String find) async {
    return await _repository.searchUsers(find);
  }
}
