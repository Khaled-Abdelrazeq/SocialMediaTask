part of 'bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class TabSelected extends HomeState {}

class UserFetched extends HomeState {}
