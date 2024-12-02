import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_task/models/user.dart';
import 'package:social_media_task/services/api/auth.dart';
import 'package:social_media_task/services/api/posts.dart';
import 'package:social_media_task/services/api/profile.dart';
import 'package:social_media_task/services/app/dialog_service.dart';
import 'package:social_media_task/services/app/snack_bar_service.dart';

import '../../../globals/app_constants.dart';
import '../../../models/post.dart';

part 'events.dart';
part 'states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStates> {
  final AuthService authService = AuthService();
  final ProfileService profileService = ProfileService();
  final PostsService postsService = PostsService();
  final SnackBarService snackBarService = SnackBarService();
  final DialogService dialogService = DialogService();

  TextEditingController nameController = TextEditingController();
  List<PostModel> posts = [];

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserPosts>((event, emit) async => onFetchUserPosts(event, emit));
    on<EditProfilePicTapped>(
        (event, emit) async => editProfilePicTapped(event, emit));
    on<EditProfileNameTapped>(
        (event, emit) async => editProfileNameTapped(event, emit));
    on<CancelEditProfileNameTapped>(
        (event, emit) async => cancelEditProfileNameTapped(event, emit));
    on<ConfirmEditProfileNameTapped>(
        (event, emit) async => confirmEditProfileNameTapped(event, emit));
  }

  Future<void> onFetchUserPosts(event, emit) async {
    emit(ProfileLoading());
    posts = await postsService.fetchUserPosts(AppConstants.savedUserModel);
    emit(ProfilePostsFetched());
  }

  Future<void> editProfilePicTapped(event, emit) async {
    emit(ProfilePicChangedRequest());
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      UserModel? user = AppConstants.savedUserModel;
      // String url = await profileService.uploadImage(image, user);
      // user = user?.copyWith(profilePic: url);
      user = user?.copyWith(profilePicPath: image.path);
      log('message: ${user?.profilePicPath}');
      //TODO: Change save user to edit user
      // await authService.saveUserToLocalStorage(user);
      if (user != null) {
        await authService.editUser(user);
        emit(ProfilePicChanged());
      }
    }
    emit(ProfileFailed());
  }

  Future<void> editProfileNameTapped(event, emit) async {
    emit(ProfileNameChanging());
    nameController.text = AppConstants.savedUserModel?.name ?? '';
  }

  Future<void> cancelEditProfileNameTapped(event, emit) async {
    emit(CancelProfileNameChanging());
  }

  Future<void> confirmEditProfileNameTapped(event, emit) async {
    emit(ProfileLoading());

    UserModel? user = AppConstants.savedUserModel;
    user = user?.copyWith(name: nameController.text);

    if (user != null) {
      await authService.editUser(user);
      emit(ProfileNameChanged());
    } else {
      emit(ProfileFailed());
    }
    log('CancelProfileNameChanging');
  }
}
