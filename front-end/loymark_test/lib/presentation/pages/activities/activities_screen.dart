import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/core/utils/utils.dart';
import 'package:loymark_test/domain/entities/activity.dart';
import 'package:loymark_test/presentation/pages/activities/activities_cubit.dart';
import 'package:loymark_test/presentation/pages/users/user_history_cubit.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    context.read<ActivitiesCubit>().getActivities();
    _scrollController.addListener(onListen);
    super.initState();
  }

  void onListen() {
    final activitiesCubit = context.read<ActivitiesCubit>();
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      if (!activitiesCubit.isAllData) activitiesCubit.getActivities();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildListItem(BuildContext context, Activity activity) {
    return ListTile(
      title: Wrap(
        children: [
          const Text('Detalle de Actividad: '),
          Text(
            activity.activity,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              const Text('Nombre: '),
              Text(
                activity.user.fullName.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Wrap(
            children: [
              const Text('Fecha de actividad: '),
              Text(
                Utils.formatDate(datetime: activity.createDate),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHistoryCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Actividades'),
        ),
        body: BlocBuilder<ActivitiesCubit, ActivitiesState>(
          builder: (context, state) {
            if (state.activities.isEmpty && state.isLoading) return const Center(child: CircularProgressIndicator());
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(thickness: 2.0),
              physics: const BouncingScrollPhysics(),
              itemCount: state.activities.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index < state.activities.length) {
                  final activity = state.activities[index];
                  return _buildListItem(context, activity);
                } else if (context.read<ActivitiesCubit>().isAllData) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'No hay más información para mostrar',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ));
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
