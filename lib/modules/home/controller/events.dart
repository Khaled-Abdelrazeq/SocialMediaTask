part of 'bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchSavedUser extends HomeEvent {}

class SelectTab extends HomeEvent {
  final int selectedIndex;

  SelectTab({required this.selectedIndex});
}
