import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task/globals/app_enums.dart';
import 'package:social_media_task/modules/components/app_cached_image.dart';
import 'package:social_media_task/modules/components/app_text.dart';
import 'package:social_media_task/modules/components/app_text_form_field.dart';
import 'package:social_media_task/modules/profile/controller/bloc.dart';

import '../../../globals/app_constants.dart';
import '../../components/edit_image_camera_icon.dart';
import '../../components/person_icon_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileStates>(
        listener: (context, state) async {
      if (state is ProfilePicChangedRequest) {}
    }, builder: (context, state) {
      ProfileBloc controller = context.read<ProfileBloc>();
      return Container(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Column(
              children: [
                /// Profile information
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Stack(
                    children: [
                      if (AppConstants.savedUserModel?.profilePic != null ||
                          AppConstants.savedUserModel?.profilePicPath == null)
                        AppCachedImage(
                          imageUrl: AppConstants.savedUserModel?.profilePic,
                          errorWidget: const PersonIconWidget(),
                          width: 150,
                          height: 150,
                        ),
                      if (AppConstants.savedUserModel?.profilePicPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1222),
                          child: Image.file(
                            File(AppConstants.savedUserModel!.profilePicPath!),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: EditImageCameraIcon(
                          onTap: () => controller.add(EditProfilePicTapped()),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if (state is! ProfileNameChanging) {
                      controller.add(EditProfileNameTapped());
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: state is! ProfileNameChanging,
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(width: 6),
                            ],
                          ),
                        ),
                        state is! ProfileNameChanging
                            ? AppText(
                                text: AppConstants.savedUserModel?.name,
                                fontSize: 20,
                                fontsWeight: FontsWeight.extraBold,
                              )
                            : Expanded(
                                child: AppTextFormField(
                                  hintText: AppConstants.savedUserModel?.name,
                                  backgroundColor: Colors.grey.shade200,
                                  textController: controller.nameController,
                                  borderColor: Colors.grey.shade300,
                                ),
                              ),
                        Visibility(
                          visible: state is ProfileNameChanging,
                          child: Row(
                            children: [
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () => controller
                                    .add(ConfirmEditProfileNameTapped()),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green.shade700,
                                ),
                              ),
                              const SizedBox(width: 2),
                              GestureDetector(
                                onTap: () => controller
                                    .add(CancelEditProfileNameTapped()),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
