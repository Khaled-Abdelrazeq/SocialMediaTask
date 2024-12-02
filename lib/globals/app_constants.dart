import 'package:social_media_task/models/post.dart';

import '../models/user.dart';

class AppConstants {
  /// Local storage keys
  static const String loggedInUser = "LOGGED_IN_USER";
  static const String posts = "POSTS";
  static const String users = "USERS";

  /// Global vars
  static UserModel? savedUserModel;
  static List<PostModel> allPosts = [];

  /// Sorting factors weight
  static double likesWeight = 0.6;
  static double recentWeight = 1 - likesWeight;
}
