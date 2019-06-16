import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  Future<int> getInt (String key) async {
    final preferences = await _preferences;
    return preferences.getInt(key);
  }

  void setInt(String key, int value) async {
    final preferences = await _preferences;
    preferences.setInt(key, value);
  }
}
