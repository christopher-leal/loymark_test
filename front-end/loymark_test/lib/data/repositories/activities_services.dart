import 'package:loymark_test/core/dio.dart';
import 'package:loymark_test/domain/entities/activity.dart';
import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/api_response.dart';
import 'package:loymark_test/domain/repositories/activities_repository.dart';

class ActivitiesService extends ActivitiesRepository {
  @override
  Future<ApiListResponse<Activity>> getActivities(int offset, {int attempts = 0}) async {
    try {
      final response = await dio.post('/activity/getActivities', data: {'offset': offset, 'order': 'createDate'});
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
        if (apiResponse.success) {
          final totalItems = apiResponse.data['totalItems'] as int;
          final items = apiResponse.data['items'] as Iterable;
          final users = items.map((item) => Activity.fromJson(item as Map<String, dynamic>)).toList();
          return ApiListResponse(items: users, totalItems: totalItems);
        }
      }
    } catch (e) {
      print('$e getActivities $attempts');
      if (attempts < 3) return await getActivities(offset, attempts: attempts + 1);
    }
    return ApiListResponse(items: [], totalItems: 0);
  }

  @override
  Future<List<Activity>> getActivitiesByUser(int userId, int offset, {int attempts = 0}) async {
    try {
      final response = await dio.post('/activity/getActivitiesByUser', data: {'offset': offset, 'userId': userId, 'order': 'createDate'});
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
        if (apiResponse.success) {
          final items = apiResponse.data['items'] as Iterable;
          final users = items.map((item) => Activity.fromJson(item as Map<String, dynamic>)).toList();
          return users;
        }
      }
    } catch (e) {
      print('$e getActivitiesByUser $attempts');
      if (attempts < 3) return await getActivitiesByUser(userId, offset, attempts: attempts + 1);
    }
    return [];
  }
}
