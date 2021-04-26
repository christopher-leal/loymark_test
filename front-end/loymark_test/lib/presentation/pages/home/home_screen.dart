import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loymark_test/presentation/pages/home/home_cubit.dart';
import 'package:loymark_test/presentation/pages/users/users_cubit.dart';
import 'package:loymark_test/presentation/pages/users/users_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => UsersCubit(context.read())),
      ],
      child: Scaffold(
          bottomNavigationBar: _BuildBottomBar(),
          body: BlocBuilder<HomeCubit, int>(
            builder: (context, state) {
              return IndexedStack(
                index: state,
                children: [
                  UsersScreen(),
                  const Placeholder(),
                ],
              );
            },
          )),
    );
  }
}

class _BuildBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: context.read<HomeCubit>().changePage,
          currentIndex: state,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Usuarios'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Actividades'),
          ],
        );
      },
    );
  }
}
