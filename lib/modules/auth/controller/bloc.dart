import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task/globals/logic_utilities.dart';
import 'package:social_media_task/models/user.dart';
import 'package:social_media_task/services/api/auth.dart';

part 'events.dart';
part 'states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async => onLogin(event, emit));
    on<CheckUser>((event, emit) => checkLoggedInUser(event, emit));
    on<LogoutEvent>((event, emit) async => logout(event, emit));
    on<CreateNewAccountTapped>(
        (event, emit) async => onCreateNewAccountTapped(event, emit));
    on<OnLoginTapped>((event, emit) async => onLoginTapped(event, emit));
    on<CreateNewAccount>(
        (event, emit) async => onCreateNewAccount(event, emit));
  }

  Future<void> onLogin(event, emit) async {
    emit(AuthLoading());
    final user = await authService.login(event.email, event.password);
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthError(message: "Invalid credentials"));
    }
  }

  Future<void> checkLoggedInUser(event, emit) async {
    emit(AuthLoading());
    UserModel? user = await authService.fetchLoggedInUser();
    if (user == null) {
      emit(AuthUnAuthenticated(message: 'You need to login first'));
    } else {
      emit(AuthAuthenticated(user: user));
    }
  }

  Future<void> logout(event, emit) async {
    emit(AuthLoading());
    try {
      await authService.logout();
      emit(AuthUnAuthenticated(message: 'Logged out successfully'));
    } catch (error) {
      emit(AuthError(message: '$error'));
    }
  }

  Future<void> onCreateNewAccountTapped(event, emit) async {
    emit(GotoSignupView());
  }

  Future<void> onLoginTapped(event, emit) async {
    emit(GotoLoginView());
  }

  Future<void> onCreateNewAccount(CreateNewAccount event, emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    UserModel userModel = UserModel(
      id: LogicUtilities.generateID(length: 10),
      email: event.email,
      password: event.password,
      name: event.username,
    );

    String check = await authService.addUserToLocalStorage(userModel);
    if (check != '') {
      emit(AuthError(message: check));
    } else {
      emit(AuthAccountCreated());
    }
  }
}
