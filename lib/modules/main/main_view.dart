import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/modules/auth/controller/bloc.dart';

import '../../routes/routes_constants.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is AuthInitial ||
            state is AuthError ||
            state is AuthUnAuthenticated) {
          context.go(RoutesConstants.loginView);
        } else if (state is AuthAuthenticated) {
          context.go(RoutesConstants.homeView);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return Container();
          },
        ),
      ),
    );
  }
}
