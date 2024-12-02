import 'dart:convert';

import 'package:social_media_task/globals/app_constants.dart';
import 'package:social_media_task/globals/local_storage.dart';
import 'package:social_media_task/globals/logic_utilities.dart';
import 'package:social_media_task/models/post.dart';
import 'package:social_media_task/models/user.dart';

import '../../globals/typedef.dart';

class PostsService {
  Future<List<PostModel>> fetchAllPosts() async {
    List<PostModel> allPosts = [];
    String? posts = await LocalStorage.getData(key: AppConstants.posts);
    if (posts != null) {
      List postsList = jsonDecode(posts);
      allPosts = PostModel.listFromJson(postsList);

      /// Sorting posts
      allPosts = LogicUtilities.sortPosts(allPosts);
      AppConstants.allPosts = allPosts;
    }
    return allPosts;
  }

  Future<void> addNewPost(PostModel? post) async {
    if (post != null) {
      try {
        AppConstants.allPosts.add(post);
        List<DataMap> postsMap = PostModel.listToJson(AppConstants.allPosts);
        await LocalStorage.saveData(
            key: AppConstants.posts, data: jsonEncode(postsMap));
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> replacePosts(List<PostModel> posts) async {
    List<DataMap> postsMap = PostModel.listToJson(posts);
    await LocalStorage.saveData(
        key: AppConstants.posts, data: jsonEncode(postsMap));
  }

  Future<List<PostModel>> fetchUserPosts(UserModel? user) async {
    List<PostModel> allPosts = [];
    String? posts = await LocalStorage.getData(key: AppConstants.posts);
    if (posts != null) {
      List postsList = jsonDecode(posts);
      allPosts = PostModel.listFromJson(postsList);

      /// Fetch only user posts
      allPosts = allPosts.where((e) => e.userModel?.id == user?.id).toList();

      /// Sorting posts
      allPosts = LogicUtilities.sortPosts(allPosts);
      AppConstants.allPosts = allPosts;
    }
    return allPosts;
  }

  Future<void> deletePost(String postID) async {
    AppConstants.allPosts.removeWhere((element) => element.id == postID);
    await replacePosts(AppConstants.allPosts);
  }

  Future<void> editPost(PostModel post) async {
    int postIndex =
        AppConstants.allPosts.indexWhere((element) => element.id == post.id);
    AppConstants.allPosts[postIndex] = post;
    await replacePosts(AppConstants.allPosts);
  }
}
