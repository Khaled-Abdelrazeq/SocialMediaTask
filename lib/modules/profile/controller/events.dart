part of 'bloc.dart';

@immutable
abstract class ProfileEvent {}

class FetchUserPosts extends ProfileEvent {}

class EditProfilePicTapped extends ProfileEvent {}

class EditProfileNameTapped extends ProfileEvent {}

class CancelEditProfileNameTapped extends ProfileEvent {}

class ConfirmEditProfileNameTapped extends ProfileEvent {}
