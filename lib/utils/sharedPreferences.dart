import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedUserState {
  String value;
  Future<String> readFamilyId();
  void saveFamilyId(value);
  void delete();
  // Future<dynamic> readTheme(String key);
  // void saveTheme(String key, dynamic value);
  // Future<bool> deleteTheme(String key);

}

class UserState implements SharedUserState {
  String value;
  final key = 'user_state';

  @override
  Future<String> readFamilyId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? null;
    print(value);
    return value;
  }

  void saveFamilyId(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print(value);
  }

  @override
  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    print(value);
  }

  static void saveTheme(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readTheme(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteTheme(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
