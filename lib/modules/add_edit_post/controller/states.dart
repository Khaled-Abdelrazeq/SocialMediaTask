part of 'bloc.dart';

@immutable
abstract class AddEditPostStates {}

class AddEditInitial extends AddEditPostStates {}

class AddEditLoading extends AddEditPostStates {}

class AddInitializePost extends AddEditPostStates {}

class PostImageChanged extends AddEditPostStates {}

class PostAddedSuccessfully extends AddEditPostStates {
  final PostModel? post;

  PostAddedSuccessfully({required this.post});
}

class PostEditedSuccessfully extends AddEditPostStates {
  final PostModel? post;

  PostEditedSuccessfully({required this.post});
}

class Failed extends AddEditPostStates {}
