import 'package:social_media_task/globals/typedef.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? profilePic;
  final String? profilePicPath;
  final String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profilePic,
    this.profilePicPath,
    this.password,
  });

  factory UserModel.empty() => UserModel(
        id: null,
        name: null,
        email: null,
        profilePic: null,
        profilePicPath: null,
        password: null,
      );

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePic,
    String? profilePicPath,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
        profilePicPath: profilePicPath ?? this.profilePicPath,
        password: password ?? this.password,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profile_pic'],
      profilePicPath: json['profile_pic_path'],
      password: json['password'],
    );
  }

  static List<UserModel> listFromJson(DynamicList list) {
    List<UserModel> users = [];
    if (list.isNotEmpty) {
      for (var user in list) {
        users.add(UserModel.fromJson(user));
      }
    }
    return users;
  }

  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
      'profile_pic_path': profilePicPath,
      'password': password,
    };
  }

  static List<DataMap> listToJson(List<UserModel> users) {
    List<DataMap> returnedUsers = [];
    for (var user in users) {
      returnedUsers.add(user.toJson());
    }
    return returnedUsers;
  }
}
