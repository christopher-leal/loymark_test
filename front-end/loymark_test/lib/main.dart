import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loymark_test/dependencies.dart';
import 'package:loymark_test/presentation/pages/activities/activities_cubit.dart';
import 'package:loymark_test/presentation/pages/home/countries_cubit.dart';
import 'package:loymark_test/presentation/pages/home/home_screen.dart';
import 'package:loymark_test/presentation/pages/users/users_cubit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (context) => CountriesCubit(context.read())..getCountries()),
          BlocProvider(create: (context) => UsersCubit(context.read(), context.read())),
          BlocProvider(create: (context) => ActivitiesCubit(context.read())),
        ],
        child: MaterialApp(
          title: 'Loymark',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', 'ES'),
          ],
          home: HomeScreen(),
        ),
      ),
    );
  }
}
