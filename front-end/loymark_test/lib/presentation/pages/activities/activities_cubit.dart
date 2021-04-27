import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/domain/entities/activity.dart';
import 'package:loymark_test/domain/usecases/get_activities_usecase.dart';

class ActivitiesState {
  ActivitiesState(this.activities, {this.isLoading = false});
  final List<Activity> activities;
  final bool isLoading;
}

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._getActivitiesUseCase) : super(ActivitiesState([]));
  final GetActivitiesUseCase _getActivitiesUseCase;
  int totalItems = 0;
  int offset = 0;

  bool get isAllData => totalItems == state.activities.length;

  Future<void> getActivities({bool refreshList = false}) async {
    if (refreshList) {
      offset = 0;
      emit(ActivitiesState([], isLoading: true));
    } else {
      emit(ActivitiesState([...state.activities], isLoading: true));
    }
    final data = await _getActivitiesUseCase.getActivities(offset);
    totalItems = data.totalItems;
    emit(ActivitiesState([...state.activities, ...data.items]));
    offset += 20;
  }

  Future<void> getActivitiesByUser(int userId) async {
    emit(ActivitiesState([], isLoading: true));
    final activities = await _getActivitiesUseCase.getActivitiesByUser(userId, offset);
    emit(ActivitiesState(activities));
  }
}
