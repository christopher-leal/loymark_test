import 'package:loymark_test/core/environment.dart';
import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/api_response.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/domain/repositories/users_repository.dart';
import 'package:requests/requests.dart';

class UsersService extends UsersRepository {
  @override
  Future<ApiListResponse<User>> getUsers(int offset, {int attempts = 0}) async {
    try {
      final response = await Requests.post('${Environment.apiUrl}/user/getUsers', body: {'offset': offset}, bodyEncoding: RequestBodyEncoding.JSON);
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.json() as Map<String, dynamic>);
        if (apiResponse.success) {
          final totalItems = apiResponse.data['totalItems'] as int;
          final items = apiResponse.data['items'] as Iterable;
          final users = items.map((item) => User.fromJson(item as Map<String, dynamic>)).toList();
          return ApiListResponse(items: users, totalItems: totalItems);
        }
      }
    } catch (e) {
      print('$e getUsers $attempts');
      if (attempts < 3) return await getUsers(offset, attempts: attempts + 1);
    }
    return ApiListResponse(items: [], totalItems: 0);
  }

  @override
  Future<List<User>> searchUsers(String find, {int attempts = 0}) async {
    try {
      final response = await Requests.post('${Environment.apiUrl}/user/searchUser', body: {'find': find}, bodyEncoding: RequestBodyEncoding.JSON);
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.json() as Map<String, dynamic>);
        if (apiResponse.success) {
          final items = apiResponse.data['items'] as Iterable;
          final users = items.map((item) => User.fromJson(item as Map<String, dynamic>)).toList();
          return users;
        }
      }
    } catch (e) {
      print('$e searchUsers $attempts');
      if (attempts < 3) return await searchUsers(find, attempts: attempts + 1);
    }
    return [];
  }

  @override
  Future<bool> upsertUser(User user, {int attempts = 0}) async {
    try {
      final response = await Requests.post('${Environment.apiUrl}/user/upsertUser', body: user.toJson(), bodyEncoding: RequestBodyEncoding.JSON);
      // final response = await Requests.post('/user/upsertUser', data: user.toJson());
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.json() as Map<String, dynamic>);
        return apiResponse.success;
      }
    } catch (e) {
      print('$e upsertUser $attempts');
      if (attempts < 3) return await upsertUser(user, attempts: attempts + 1);
    }
    return false;
  }

  @override
  Future<bool> deleteUser(int id, {int attempts = 0}) async {
    try {
      final response = await Requests.get('${Environment.apiUrl}/user/delete/$id');
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.json() as Map<String, dynamic>);
        return apiResponse.success;
      }
    } catch (e) {
      print('$e deleteUser $attempts');
      if (attempts < 3) return await deleteUser(id, attempts: attempts + 1);
    }
    return false;
  }
}
