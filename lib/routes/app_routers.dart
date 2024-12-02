import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/models/post.dart';
import 'package:social_media_task/modules/add_edit_post/controller/bloc.dart';
import 'package:social_media_task/modules/add_edit_post/view/add_edit_post.dart';
import 'package:social_media_task/modules/auth/view/signup.dart';
import 'package:social_media_task/modules/home/view/home.dart';
import 'package:social_media_task/modules/main/main_view.dart';

import '../modules/auth/view/login.dart';
import 'routes_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: RoutesConstants.mainView,
      builder: (BuildContext context, GoRouterState state) {
        return const MainView();
      },
    ),
    GoRoute(
      path: RoutesConstants.homeView,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: RoutesConstants.loginView,
      builder: (BuildContext context, GoRouterState state) {
        return LoginView();
      },
    ),
    GoRoute(
      path: RoutesConstants.signup,
      builder: (BuildContext context, GoRouterState state) {
        return SignupView();
      },
    ),
    GoRoute(
      path: RoutesConstants.addPost,
      builder: (BuildContext context, GoRouterState state) {
        return const AddEditPostView();
      },
    ),
    GoRoute(
      path: RoutesConstants.editPost,
      builder: (BuildContext context, state) {
        return BlocProvider(
            create: (context) => AddEditPostBloc()
              ..add(InitializePostModel(post: state.extra as PostModel)),
            child: const AddEditPostView());
      },
    ),
  ]);
}
