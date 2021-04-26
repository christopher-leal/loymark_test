import 'package:loymark_test/data/models/api_list_response.dart';
import 'package:loymark_test/domain/entities/activity.dart';
import 'package:loymark_test/domain/repositories/activities_repository.dart';

class GetActivitiesUseCase {
  GetActivitiesUseCase(this._repository);
  final ActivitiesRepository _repository;

  Future<ApiListResponse<Activity>> getActivities(int offset) async {
    return await _repository.getActivities(offset);
  }

  Future<ApiListResponse<Activity>> getActivitiesByUser(int userId, int offset) async {
    return await _repository.getActivitiesByUser(userId, offset);
  }
}
