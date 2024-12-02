import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/globals/logic_utilities.dart';
import 'package:social_media_task/modules/feed/controller/bloc.dart';
import 'package:social_media_task/routes/routes_constants.dart';
import 'package:social_media_task/services/app/dialog_service.dart';

import '../../../globals/app_constants.dart';
import '../../../globals/app_enums.dart';
import '../../../models/post.dart';
import '../../components/app_text.dart';
import '../../components/create_new_post.dart';
import '../../components/loading_dialog.dart';
import '../../components/post_item.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: BlocConsumer<FeedBloc, FeedStates>(
              listener: (BuildContext context, FeedStates state) {
                FeedBloc controller = context.read<FeedBloc>();
                if (state is DeleteConfirmationDialog) {
                  LogicUtilities.showDeleteDialog(
                      context: context,
                      onDeleteTapped: () => controller.add(
                          ConfirmDelete(id: state.postId, context: context)),
                      onCancelTapped: () => controller.add(CancelDelete()));
                } else if (state is DeleteCancelled || state is PostDeleted) {
                  DialogService().hideLoading(context);
                } else if (state is PostAdded) {
                  context
                      .push(RoutesConstants.addPost)
                      .then((value) => controller.add(FetchPosts()));
                } else if (state is EditPostTapped) {
                  context
                      .push(RoutesConstants.editPost, extra: (state).post)
                      .then((value) => controller.add(FetchPosts()));
                }
              },
              builder: (context, state) {
                FeedBloc controller = context.read<FeedBloc>();
                return Stack(
                  children: [
                    Column(
                      children: [
                        /// Add new post
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CreateNewPostWidget(
                            userProfilePic:
                                AppConstants.savedUserModel?.profilePic,
                            onWritePostTapped: () =>
                                controller.add(AddNewPost()),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Expanded(
                          child: controller.posts.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    PostModel post = controller.posts[index];
                                    return PostItem(
                                      post: post,
                                      onDeleteButtonTapped: () =>
                                          controller.add(ShowConfirmationDialog(
                                              id: post.id)),
                                      onEditButtonTapped: () =>
                                          controller.add(EditPost(post: post)),
                                      onLikeTapped: () => controller
                                          .add(AddRemoveLike(postId: post.id)),
                                      liked:
                                          LogicUtilities.ifUserLikedPost(post),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5,
                                  ),
                                  itemCount: controller.posts.length,
                                )
                              : const AppText(
                                  text: 'There is no posts yet',
                                  fontSize: 16,
                                  fontsWeight: FontsWeight.medium,
                                  textColor: Colors.white,
                                ),
                        )
                      ],
                    ),
                    if (state is FeedLoading) const LoadingDialog(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
