part of 'bloc.dart';

@immutable
abstract class AddEditPostEvent {}

class InitializePostModel extends AddEditPostEvent {
  final PostModel post;

  InitializePostModel({required this.post});
}

class AttachImage extends AddEditPostEvent {}

class AddNew extends AddEditPostEvent {}

class Edit extends AddEditPostEvent {}
