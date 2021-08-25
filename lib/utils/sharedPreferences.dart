import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedUserState {
  String value;
  Future<String> readFamilyId();
  void saveFamilyId(value);
  void delete();
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
}
