import 'package:loymark_test/core/dio.dart';
import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/api_response.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';

class UserService extends UsersRepository {
  @override
  Future<ApiListResponse<User>> getUsers(int offset) async {
    try {
      final response = await dio.post('/user/getUsers', data: {'offset': offset});
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
        if (apiResponse.success) {
          final totalItems = apiResponse.data['totalItems'] as int;
          final items = apiResponse.data['items'] as Iterable;
          final users = items.map((item) => User.fromJson(item as Map<String, dynamic>)).toList();
          return ApiListResponse(items: users, totalItems: totalItems);
        }
      }
    } catch (e) {
      print(e);
    }
    return ApiListResponse(items: [], totalItems: 0);
  }

  @override
  Future<ApiListResponse<User>> searchUsers(String find) async {
    // TODO: implement searchUsers
    throw UnimplementedError();
  }

  @override
  Future<bool> upsertUser() async {
    // TODO: implement upsertUser
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteUser(int id) async {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
