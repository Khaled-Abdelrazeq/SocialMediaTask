import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/modules/home/controller/bloc.dart';

import '../../../routes/routes_constants.dart';
import '../../auth/controller/bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
              );
            },
            listener: (BuildContext context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is AuthUnAuthenticated) {
                context.go(RoutesConstants.loginView);
              }
            },
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        HomeBloc homeBloc = context.read<HomeBloc>();
        return homeBloc.screens[homeBloc.selectedIndex];
      }),
      bottomNavigationBar:
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        HomeBloc homeBloc = context.read<HomeBloc>();
        return BottomNavigationBar(
          currentIndex: homeBloc.selectedIndex,
          onTap: (index) => homeBloc.add(SelectTab(selectedIndex: index)),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
