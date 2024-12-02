// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task/modules/feed/controller/bloc.dart';
import 'package:social_media_task/modules/home/controller/bloc.dart';
import 'package:social_media_task/modules/profile/controller/bloc.dart';
import 'package:social_media_task/routes/app_routers.dart';

import 'modules/add_edit_post/controller/bloc.dart';
import 'modules/auth/controller/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc()..add(CheckUser()),
        ),
        BlocProvider(
          create: (_) => HomeBloc()..add(FetchSavedUser()),
        ),
        BlocProvider(
          create: (_) => FeedBloc()..add(FetchPosts()),
        ),
        BlocProvider(
          create: (_) => ProfileBloc()..add(FetchUserPosts()),
        ),
        BlocProvider(create: (_) => AddEditPostBloc()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          title: 'Social Media app',
          debugShowCheckedModeBanner: false,
          // : RoutesConstants.homePage,
          routerConfig: AppRouter.router,
          builder: (context, Widget? child) =>
              Directionality(textDirection: TextDirection.ltr, child: child!),
        ),
      ),
    );
  }
}
