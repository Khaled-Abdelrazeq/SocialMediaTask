part of 'bloc.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfilePostsFetched extends ProfileStates {}

class ProfilePicChangedRequest extends ProfileStates {}

class ProfilePicChanged extends ProfileStates {}

class ProfileNameChanging extends ProfileStates {}

class CancelProfileNameChanging extends ProfileStates {}

class ProfileNameChanged extends ProfileStates {}

class ProfileFailed extends ProfileStates {}
