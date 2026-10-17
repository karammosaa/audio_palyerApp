import 'package:shared_preferences/shared_preferences.dart';

class Sheredprefhelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //set
  static Future<bool> setData({required String k, required dynamic v}) async {
    if (v is String) return await sharedPreferences.setString(k, v);

    if (v is int) return await sharedPreferences.setInt(k, v);

    if (v is double) return await sharedPreferences.setDouble(k, v);

    if (v is bool) return await sharedPreferences.setBool(k, v);

    if (v is List<String>) return await sharedPreferences.setStringList(k, v);

    return false;
  }

  //get
  static String getString({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }

  static int getInt({required String key}) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  static bool getBool({required String key}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static List<String> getList({required String key}) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  static double getDouble({required String key}) {
    return sharedPreferences.getDouble(key) ?? 0.0;
  }
}
