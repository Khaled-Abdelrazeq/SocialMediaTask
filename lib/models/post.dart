import 'package:social_media_task/models/user.dart';

import '../globals/typedef.dart';

class PostModel {
  final String id;
  final String? text;
  final String? imageUrl;
  final String? imageFilePath;
  final DateTime? createdAt;
  final UserModel? userModel;
  final List<String>? likes;

  PostModel({
    required this.id,
    this.text,
    this.imageUrl,
    this.imageFilePath,
    this.createdAt,
    this.userModel,
    this.likes,
  });

  factory PostModel.empty() => PostModel(
        id: '',
        text: null,
        imageUrl: null,
        imageFilePath: null,
        createdAt: null,
        userModel: null,
        likes: [],
      );

  PostModel copyWith({
    String? id,
    String? text,
    String? imageUrl,
    String? imageFilePath,
    DateTime? createdAt,
    UserModel? userModel,
    List<String>? likes,
  }) =>
      PostModel(
        id: id ?? this.id,
        text: text ?? this.text,
        imageUrl: imageUrl ?? this.imageUrl,
        imageFilePath: imageFilePath ?? this.imageFilePath,
        createdAt: createdAt ?? this.createdAt,
        userModel: userModel ?? this.userModel,
        likes: likes ?? this.likes,
      );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<String> likes = [];
    if (json['likes'] != null) {
      json['likes'].forEach((like) {
        likes.add(like);
      });
    }
    return PostModel(
      id: json['id'],
      text: json['text'],
      imageUrl: json['image_url'],
      imageFilePath: json['image_file_path'],
      createdAt: DateTime.parse(json['created_at']),
      userModel: UserModel.fromJson(json['user']),
      likes: likes,
    );
  }

  static List<PostModel> listFromJson(DynamicList list) {
    List<PostModel> posts = [];
    if (list.isNotEmpty) {
      for (var post in list) {
        posts.add(PostModel.fromJson(post));
      }
    }
    return posts;
  }

  DataMap toJson() {
    return {
      'id': id,
      'text': text,
      'image_url': imageUrl,
      'image_file_path': imageFilePath,
      'created_at': createdAt.toString(),
      'user': userModel?.toJson(),
      'likes': likes,
    };
  }

  static List<DataMap> listToJson(List<PostModel> posts) {
    List<DataMap> returnedPosts = [];
    for (var post in posts) {
      returnedPosts.add(post.toJson());
    }
    return returnedPosts;
  }
}
