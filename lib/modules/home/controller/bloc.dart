import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task/models/user.dart';
import 'package:social_media_task/modules/feed/view/feed.dart';
import 'package:social_media_task/modules/profile/view/profile.dart';
import 'package:social_media_task/services/api/auth.dart';

part 'events.dart';
part 'states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthService authService = AuthService();

  int selectedIndex = 0;
  List<Widget> screens = const [
    FeedView(),
    ProfileView(),
  ];

  HomeBloc() : super(HomeInitial()) {
    on<FetchSavedUser>((event, emit) async => fetchUser(event, emit));
    on<SelectTab>((event, emit) async => onSelectTapClicked(event, emit));
  }

  Future<void> onSelectTapClicked(event, emit) async {
    emit(HomeLoading());
    selectedIndex = event.selectedIndex;
    emit(TabSelected());
  }

  Future<void> fetchUser(event, emit) async {
    emit(HomeLoading());
    UserModel? user = await authService.fetchLoggedInUser();
    await authService.fetchSavedUser(user?.email ?? '');
    emit(UserFetched());
  }
}
