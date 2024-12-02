import 'package:flutter/material.dart';
import 'package:social_media_task/modules/components/person_icon_widget.dart';

import 'app_cached_image.dart';
import 'app_text_form_field.dart';

class CreateNewPostWidget extends StatelessWidget {
  const CreateNewPostWidget({
    super.key,
    this.userProfilePic,
    this.onWritePostTapped,
    this.borderColor,
    this.backgroundColor,
  });

  final String? userProfilePic;
  final VoidCallback? onWritePostTapped;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onWritePostTapped,
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppCachedImage(
              imageUrl: userProfilePic,
              width: 40,
              height: 40,
              borderRadius: 100,
              errorWidget: const PersonIconWidget(),
            ),
            Expanded(
              child: AppTextFormField(
                hintText: 'What is on your mind...',
                backgroundColor: Colors.transparent,
                borderColor: Colors.transparent,
                onTap: onWritePostTapped,
                autofocus: false,
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
