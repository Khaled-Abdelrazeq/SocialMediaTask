import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_task/globals/app_constants.dart';
import 'package:social_media_task/modules/components/person_icon_widget.dart';

import '../../globals/app_enums.dart';
import '../../globals/logic_utilities.dart';
import '../../models/post.dart';
import '../feed/components/like_widget.dart';
import 'app_cached_image.dart';
import 'app_text.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    required this.onDeleteButtonTapped,
    required this.onEditButtonTapped,
    this.onLikeTapped,
    required this.liked,
  });

  final PostModel post;
  final VoidCallback onDeleteButtonTapped;
  final VoidCallback onEditButtonTapped;
  final VoidCallback? onLikeTapped;
  final bool liked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          /// Post header and content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                /// Header
                Row(
                  children: [
                    AppCachedImage(
                      imageUrl: post.userModel?.profilePic,
                      width: 40,
                      height: 40,
                      borderRadius: 100,
                      errorWidget: const PersonIconWidget(),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: post.userModel?.name ?? '',
                            fontsWeight: FontsWeight.bold,
                            fontSize: 15,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                          AppText(
                            text: LogicUtilities.getPostTime(post.createdAt),
                            fontsWeight: FontsWeight.regular,
                            fontSize: 13,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          post.userModel?.id == AppConstants.savedUserModel?.id,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: onEditButtonTapped,
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.black.withOpacity(0.60),
                              )),
                          GestureDetector(
                              onTap: onDeleteButtonTapped,
                              child: Icon(
                                Icons.delete,
                                color: Colors.black.withOpacity(0.60),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// Content
                AppText(
                  text: post.text,
                  fontsWeight: FontsWeight.semiBold,
                  fontSize: 15,
                  maxLines: 10,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ],
            ),
          ),
          if (post.imageUrl != null || post.imageFilePath != null)
            Column(
              children: [
                const SizedBox(height: 10),
                if (post.imageUrl != null)
                  AppCachedImage(
                    imageUrl: post.imageUrl,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    boxFit: BoxFit.scaleDown,
                  ),
                if (post.imageFilePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(post.imageFilePath!),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                if (post.likes?.isNotEmpty ?? false)
                  Row(
                    children: [
                      AppText(
                        text: '${post.likes?.length}',
                        fontSize: 17,
                        fontsWeight: FontsWeight.medium,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                LikeWidget(liked: liked, onLikeTapped: onLikeTapped),
              ],
            ),
          )
        ],
      ),
    );
  }
}
