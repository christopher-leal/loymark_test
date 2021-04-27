import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:loymark_test/core/utils/utils.dart';
import 'package:loymark_test/domain/entities/user.dart';
import 'package:loymark_test/presentation/pages/activities/activities_cubit.dart';
import 'package:loymark_test/presentation/pages/home/countries_cubit.dart';
import 'package:loymark_test/presentation/pages/users/upsert_user_cubit.dart';
import 'package:loymark_test/presentation/pages/users/users_cubit.dart';

class UpsertUserScreen extends StatelessWidget {
  UpsertUserScreen({Key key, this.user}) : super(key: key);
  final User user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem<String>> _getCountriesItems(BuildContext context) {
    final countriesCubit = context.read<CountriesCubit>();

    final countries = <DropdownMenuItem<String>>[
      const DropdownMenuItem(
        value: '',
        child: Text('Selecciona un pais'),
      )
    ];
    for (final element in countriesCubit.state) {
      countries.add(DropdownMenuItem(
        value: element.alpha3.toUpperCase(),
        child: Text(element.name),
      ));
    }
    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpsertUserCubit(context.read())..init(user),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(user != null ? 'Nuevo usuario' : 'Editar usuario'),
          ),
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  Utils.dismissKeyboard(context);
                  context.read<UpsertUserCubit>().upsertUser();
                },
                child: const Icon(Icons.save),
              );
            },
          ),
          body: BlocConsumer<UpsertUserCubit, UpsertUserState>(listener: (context, state) {
            if (state.error != null) {
              Utils.showSnackBar(_scaffoldKey, context, state.error);
              return;
            }
            if (state.isSuccess) {
              final usersCubit = context.read<UsersCubit>();
              final acivitiesCubit = context.read<ActivitiesCubit>();
              usersCubit.getUsers(refreshList: true);
              acivitiesCubit.getActivities(refreshList: true);
              return Navigator.of(context).pop(true);
            }
          }, builder: (context, state) {
            if (state.isLoading) return const Center(child: CircularProgressIndicator());
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: context.read<UpsertUserCubit>().nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'Ingresa tu nombre',
                      ),
                    ),
                    TextField(
                      controller: context.read<UpsertUserCubit>().lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Apellido',
                        hintText: 'Ingresa tu apellido',
                      ),
                    ),
                    TextField(
                      controller: context.read<UpsertUserCubit>().emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Ingresa tu email',
                      ),
                    ),
                    TextField(
                      controller: context.read<UpsertUserCubit>().birthdayController,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de nacimiento',
                        hintText: 'Ingresa tu fecha de nacimiento',
                      ),
                      onTap: () {
                        Utils.dismissKeyboard(context);
                        DatePicker.showDatePicker(
                          context,
                          locale: LocaleType.es,
                          minTime: DateTime(1960),
                          maxTime: DateTime.now(),
                          onConfirm: (time) {
                            print(time);
                            context.read<UpsertUserCubit>().birthday = time;
                            context.read<UpsertUserCubit>().birthdayController.text = Utils.formatDateWithoutTime(datetime: time);
                          },
                        );
                      },
                    ),
                    TextField(
                      controller: context.read<UpsertUserCubit>().phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        hintText: 'Ingresa tu teléfono',
                      ),
                    ),
                    DropdownButton<String>(
                      value: state.selectedCountry,
                      items: _getCountriesItems(context),
                      onChanged: (value) {
                        context.read<UpsertUserCubit>().changeCountry(value);
                      },
                      isExpanded: true,
                      itemHeight: 80,
                    ),
                    CheckboxListTile(
                      title: const Text('Recibir información'),
                      value: state.receiveNotification,
                      onChanged: (_) {
                        context.read<UpsertUserCubit>().changeReceiveNotification();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
