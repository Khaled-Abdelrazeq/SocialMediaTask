import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Obtain shared preferences.
  static late SharedPreferences localStorage;

  static saveData({required String key, required dynamic data}) async {
    localStorage = await SharedPreferences.getInstance();
    if (data.runtimeType == bool) {
      await localStorage.setBool(key, data);
    } else if (data.runtimeType == String) {
      await localStorage.setString(key, data);
    } else if (data.runtimeType == double) {
      await localStorage.setDouble(key, data);
    } else if (data.runtimeType == int) {
      await localStorage.setInt(key, data);
    } else if (data.runtimeType == List) {
      await localStorage.setStringList(key, data);
    }
  }

  static dynamic getData({required String key}) async {
    localStorage = await SharedPreferences.getInstance();
    return localStorage.get(key);
  }

  static deleteData(String key) async {
    localStorage = await SharedPreferences.getInstance();
    await localStorage.remove(key);
  }

  static Future<bool> containKey(String key) async {
    localStorage = await SharedPreferences.getInstance();
    return localStorage.containsKey(key);
  }

  static void removeKey(String key) async {
    localStorage = await SharedPreferences.getInstance();
    await localStorage.remove(key);
  }
}
