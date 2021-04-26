import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/user.dart';

abstract class UsersRepository {
  Future<ApiListResponse<User>> getUsers(int offset);
  Future<List<User>> searchUsers(String find);
  Future<bool> upsertUser();
  Future<bool> deleteUser(int id);
}
