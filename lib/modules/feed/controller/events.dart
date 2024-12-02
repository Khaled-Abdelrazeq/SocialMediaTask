part of 'bloc.dart';

@immutable
abstract class FeedEvent {}

class FeedFetchSavedUser extends FeedEvent {}

class FetchPosts extends FeedEvent {}

class AddNewPost extends FeedEvent {}

class ShowConfirmationDialog extends FeedEvent {
  final String id;

  ShowConfirmationDialog({required this.id});
}

class ConfirmDelete extends FeedEvent {
  final String id;
  final BuildContext context;

  ConfirmDelete({required this.id, required this.context});
}

class EditPost extends FeedEvent {
  final PostModel post;

  EditPost({required this.post});
}

class CancelDelete extends FeedEvent {}

class AddRemoveLike extends FeedEvent {
  final String postId;

  AddRemoveLike({required this.postId});
}
