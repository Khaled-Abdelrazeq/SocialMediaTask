import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task/globals/app_constants.dart';
import 'package:social_media_task/models/post.dart';
import 'package:social_media_task/models/user.dart';
import 'package:social_media_task/services/api/auth.dart';
import 'package:social_media_task/services/api/posts.dart';
import 'package:social_media_task/services/app/dialog_service.dart';
import 'package:social_media_task/services/app/snack_bar_service.dart';

part 'events.dart';
part 'states.dart';

class FeedBloc extends Bloc<FeedEvent, FeedStates> {
  final AuthService authService = AuthService();
  final PostsService postsService = PostsService();
  final SnackBarService snackBarService = SnackBarService();
  final DialogService dialogService = DialogService();

  UserModel user =
      UserModel(id: '', name: 'Khaled Abdelrazeq', email: 'khaled@gmail.com');
  List<PostModel> posts = [];

  FeedBloc() : super(FeedInitial()) {
    on<FeedFetchSavedUser>((event, emit) async => fetchUser(event, emit));
    on<FetchPosts>((event, emit) async => onFetchPosts(event, emit));
    on<ShowConfirmationDialog>(
        (event, emit) async => onShowConfirmationDialog(event, emit));
    on<ConfirmDelete>((event, emit) async => onConfirmDelete(event, emit));
    on<CancelDelete>((event, emit) async => onCancelDelete(event, emit));
    on<AddNewPost>((event, emit) async => onAddNewPost(event, emit));
    on<AddRemoveLike>((event, emit) async => onAddRemoveLike(event, emit));
    on<EditPost>((event, emit) async => onEditPost(event, emit));
  }

  Future<void> fetchUser(event, emit) async {
    emit(FeedLoading());
    UserModel? user = await authService.fetchLoggedInUser();
    await authService.fetchSavedUser(user?.email ?? '');
    emit(UserFetched());
  }

  Future<void> onFetchPosts(event, emit) async {
    emit(FeedLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      posts = await postsService.fetchAllPosts();
      emit(FetchPostsSuccessfully());
    } catch (error) {
      emit(Failed());
    }
  }

  Future<void> onShowConfirmationDialog(event, emit) async {
    emit(DeleteConfirmationDialog(event.id));
  }

  Future<void> onConfirmDelete(event, emit) async {
    emit(FeedLoading());
    try {
      await postsService.deletePost(event.id);
      emit(PostDeleted());
    } catch (error) {
      snackBarService.showError(event.context, message: '$error');
    }
  }

  Future<void> onCancelDelete(event, emit) async {
    emit(DeleteCancelled());
  }

  Future<void> onAddNewPost(event, emit) async {
    emit(PostAdded());
  }

  Future<void> onAddRemoveLike(event, emit) async {
    log('tapped');
    int postIndex = AppConstants.allPosts
        .indexWhere((element) => element.id == event.postId);
    PostModel? post = AppConstants.allPosts[postIndex];
    List<String> postLikes = post.likes ?? [];
    String? userID = AppConstants.savedUserModel?.id;
    bool checkLike = postLikes.contains(userID);
    log('tapped: $checkLike, id: $userID, $postLikes');
    checkLike ? postLikes.remove(userID) : postLikes.add(userID ?? '');
    post = post.copyWith(likes: postLikes);
    AppConstants.allPosts[postIndex] = post;
    await postsService.replacePosts(AppConstants.allPosts);
    emit(PostAddedLike());
  }

  Future<void> onEditPost(event, emit) async {
    emit(EditPostTapped(post: event.post));
  }
}
