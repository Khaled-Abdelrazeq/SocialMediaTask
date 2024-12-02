part of 'bloc.dart';

@immutable
abstract class FeedStates {}

class FeedInitial extends FeedStates {}

class FeedLoading extends FeedStates {}

class UserFetched extends FeedStates {}

class FetchPostsSuccessfully extends FeedStates {}

class DeleteConfirmationDialog extends FeedStates {
  final String postId;

  DeleteConfirmationDialog(this.postId);
}

class PostAdded extends FeedStates {}

class PostAddedLike extends FeedStates {}

class PostDeleted extends FeedStates {}

class DeleteCancelled extends FeedStates {}

class EditPostTapped extends FeedStates {
  final PostModel post;

  EditPostTapped({required this.post});
}

class Failed extends FeedStates {}
