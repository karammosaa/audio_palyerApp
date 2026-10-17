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
}
