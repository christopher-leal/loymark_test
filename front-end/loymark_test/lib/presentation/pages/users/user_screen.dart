import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/core/utils/utils.dart';
import 'package:loymark_test/domain/entities/activity.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/presentation/pages/activities/activities_cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key key, this.user}) : super(key: key);
  final User user;

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
      create: (context) => ActivitiesCubit(context.read())..getActivitiesByUser(user.id),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Usuario'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Información',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Wrap(
                    children: [
                      const Text('Nombre completo: ', style: TextStyle(fontSize: 16.0)),
                      Text(
                        user.fullName.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Correo: ', style: TextStyle(fontSize: 16.0)),
                      Text(
                        user.email,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Fecha de nacimiento: ', style: TextStyle(fontSize: 16.0)),
                      Text(
                        Utils.formatDateWithoutTime(datetime: user.birthday),
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Pais: ', style: TextStyle(fontSize: 16.0)),
                      Text(
                        user.country,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      const SizedBox(width: 12.0),
                      const Text('Telefono: ', style: TextStyle(fontSize: 16.0)),
                      Text(
                        user.phone ?? '-',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Recibir información: ', style: TextStyle(fontSize: 16.0)),
                      Checkbox(value: user.receiveInfo, onChanged: null),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
                  builder: (context, state) {
                    if (state.activities.isEmpty && state.isLoading) return const Center(child: CircularProgressIndicator());
                    return Column(
                      children: [
                        const Text(
                          'Actividades',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(thickness: 2.0),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.activities.length,
                            itemBuilder: (BuildContext context, int index) {
                              final activity = state.activities[index];
                              return _buildListItem(context, activity);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
