import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/activity.dart';

abstract class ActivitiesRepository {
  Future<ApiListResponse<Activity>> getActivities(int offset);
  Future<List<Activity>> getActivitiesByUser(int user, int offset);
}
