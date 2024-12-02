import 'dart:convert';

import 'package:social_media_task/globals/app_constants.dart';
import 'package:social_media_task/globals/local_storage.dart';
import 'package:social_media_task/models/user.dart';

import '../../globals/typedef.dart';

class AuthService {
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    List<UserModel> savedUsers = await getAllUsersFromLocalStorage();

    if (savedUsers.any(
        (element) => element.email == email && element.password == password)) {
      //TODO: Save user as logged in user && Fetch saved user, if null save it
      UserModel? loggedInUser = UserModel(email: email);
      LocalStorage.saveData(
          key: AppConstants.loggedInUser,
          data: jsonEncode(loggedInUser.toJson()));

      await fetchSavedUser(email);
      return AppConstants.savedUserModel;
    }
    return null;
  }

  Future<UserModel?> fetchLoggedInUser() async {
    try {
      String? userJson =
          await LocalStorage.getData(key: AppConstants.loggedInUser);
      if (userJson != null) {
        UserModel? user = UserModel.fromJson(jsonDecode(userJson));
        return user;
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchSavedUser(String email) async {
    List<UserModel> users = await getAllUsersFromLocalStorage();
    AppConstants.savedUserModel =
        users.firstWhere((element) => element.email == email);
  }

  Future<void> logout() async {
    try {
      await LocalStorage.deleteData(AppConstants.loggedInUser);
    } catch (error) {
      rethrow;
    }
  }

  Future<String> addUserToLocalStorage(UserModel user) async {
    List<UserModel> users = await getAllUsersFromLocalStorage();

    if (users.any((fetchedUser) => fetchedUser.email == user.email)) {
      return "Email is already exist";
    } else {
      users.add(user);
      await saveUsersToLocalStorage(users);
      return '';
    }
  }

  Future<List<UserModel>> getAllUsersFromLocalStorage() async {
    String? usersString = await LocalStorage.getData(key: AppConstants.users);
    if (usersString != null) {
      List usersList = jsonDecode(usersString);
      List<UserModel> users = UserModel.listFromJson(usersList);

      return users;
    }
    return [];
  }

  Future<void> saveUsersToLocalStorage(List<UserModel> users) async {
    List<DataMap> usersMap = UserModel.listToJson(users);
    await LocalStorage.saveData(
        key: AppConstants.users, data: jsonEncode(usersMap));
  }

  Future<void> editUser(UserModel user) async {
    List<UserModel> savedUsers = await getAllUsersFromLocalStorage();
    savedUsers.removeWhere((element) => element.email == user.email);
    savedUsers.add(user);
    await saveUsersToLocalStorage(savedUsers);
    AppConstants.savedUserModel = user;
  }
}
