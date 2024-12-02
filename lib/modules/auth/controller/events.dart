part of 'bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckUser extends AuthEvent {}

class OnLoginTapped extends AuthEvent {}

class CreateNewAccountTapped extends AuthEvent {}

class CreateNewAccount extends AuthEvent {
  final String email;
  final String password;
  final String username;
  CreateNewAccount({
    required this.email,
    required this.password,
    required this.username,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}
