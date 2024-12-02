import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/globals/app_enums.dart';
import 'package:social_media_task/modules/add_edit_post/controller/bloc.dart';
import 'package:social_media_task/modules/components/app_button.dart';
import 'package:social_media_task/modules/components/app_cached_image.dart';
import 'package:social_media_task/modules/components/app_text.dart';

import '../../components/edit_text_form_field_with_label.dart';

class AddEditPostView extends StatelessWidget {
  const AddEditPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditPostBloc, AddEditPostStates>(
        listener: (context, state) {
      if (state is PostAddedSuccessfully) {
        context.pop(state.post);
      } else if (state is PostEditedSuccessfully) {
        context.pop(state.post);
      }
    }, builder: (context, state) {
      final AddEditPostBloc controller = context.read<AddEditPostBloc>();
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: controller.isNewPost ? 'Add new post' : 'Edit post',
            fontsWeight: FontsWeight.bold,
            fontSize: 17,
            textColor: Colors.black,
            alignment: AlignmentDirectional.centerStart,
          ),
          leading: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              EditTextFormFieldWithLabel(
                label: '',
                textController: controller.postController,
                maxLines: 10,
                height: 120,
                autofocus: true,
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => controller.add(AttachImage()),
                child: const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppText(
                        text: 'Attach image',
                        fontSize: 16,
                        fontsWeight: FontsWeight.medium,
                        textColor: Colors.black,
                      ),
                      Icon(
                        Icons.image,
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (controller.post?.imageFilePath != null)
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(controller.post!.imageFilePath!),
                      width: 180,
                      fit: BoxFit.cover,
                    )),
              if (controller.post?.imageUrl != null &&
                  controller.post?.imageFilePath == null)
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppCachedImage(
                      imageUrl: controller.post!.imageUrl,
                      width: 180,
                    )),
              const SizedBox(height: 25),
              state is AddEditLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      label: controller.isNewPost ? 'Add' : 'Edit',
                      fontSize: 16,
                      onTap: () => controller.isNewPost
                          ? controller.add(AddNew())
                          : controller.add(Edit()),
                    )
            ],
          ),
        ),
      );
    });
  }
}
