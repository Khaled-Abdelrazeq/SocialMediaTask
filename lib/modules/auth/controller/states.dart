part of 'bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class GotoLoginView extends AuthState {}

class GotoSignupView extends AuthState {}

class AuthAccountCreated extends AuthState {}

class AuthUnAuthenticated extends AuthState {
  final String message;

  AuthUnAuthenticated({required this.message});
}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated({required this.user});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
