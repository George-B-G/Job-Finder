import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // to set and get the boolean data
  static Future<bool> putBoolData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getBoolData({
    required String key,
  }) {
    return sharedPreferences.getBool(key) ?? false;
  }

  // to set and get string data
  static Future<bool> putStringData({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getStringData({
    required String key,
  }) {
    return sharedPreferences.getString(key) ?? '';
  }
}
