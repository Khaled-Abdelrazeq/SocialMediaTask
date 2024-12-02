import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_task/globals/logic_utilities.dart';
import 'package:social_media_task/services/api/auth.dart';
import 'package:social_media_task/services/api/posts.dart';
import 'package:social_media_task/services/app/dialog_service.dart';
import 'package:social_media_task/services/app/snack_bar_service.dart';

import '../../../globals/app_constants.dart';
import '../../../models/post.dart';

part 'events.dart';
part 'states.dart';

class AddEditPostBloc extends Bloc<AddEditPostEvent, AddEditPostStates> {
  final AuthService authService = AuthService();
  final PostsService postService = PostsService();
  final SnackBarService snackBarService = SnackBarService();
  final DialogService dialogService = DialogService();

  PostModel? post = PostModel(
    id: LogicUtilities.generateID(),
    userModel: AppConstants.savedUserModel,
  );

  bool isNewPost = true;

  TextEditingController postController = TextEditingController();

  AddEditPostBloc() : super(AddEditInitial()) {
    on<InitializePostModel>(
        (event, emit) async => onInitializePostModel(event, emit));
    on<AttachImage>((event, emit) async => onAttachImage(event, emit));
    on<AddNew>((event, emit) async => onAddNewPost(event, emit));
    on<Edit>((event, emit) async => onEditPost(event, emit));
  }

  Future<void> onInitializePostModel(event, emit) async {
    post = event.post;
    isNewPost = false;
    postController.text = post?.text ?? '';
    emit(AddInitializePost());
  }

  Future<void> onAttachImage(event, emit) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      post = post?.copyWith(imageFilePath: pickedImage.path);
    }

    emit(PostImageChanged());
  }

  Future<void> onAddNewPost(event, emit) async {
    emit(AddEditLoading());
    await Future.delayed(const Duration(seconds: 2));
    post = post?.copyWith(
      text: postController.text,
      id: LogicUtilities.generateID(),
      createdAt: DateTime.now(),
    );
    log('imageFile: ${post?.imageFilePath}');
    await postService.addNewPost(post);
    emit(PostAddedSuccessfully(post: post));
  }

  Future<void> onEditPost(event, emit) async {
    emit(AddEditLoading());
    await Future.delayed(const Duration(seconds: 2));
    post = post?.copyWith(
      text: postController.text,
    );
    if (post != null) {
      await postService.editPost(post!);
    }
    emit(PostEditedSuccessfully(post: post));
  }
}
