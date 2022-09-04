import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  SharedPreferences? _preferences;
  LocalStorage._();

  factory LocalStorage() {
    _instance ??= LocalStorage._();
    _instance?._init();
    return _instance!;
  }

  _init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  save({required String key, required dynamic value}) {
    if (value == null) {
      return;
    }

    switch (value.runtimeType) {
      case String:
        _preferences?.setString(key, value);
        break;
      case int:
        _preferences?.setInt(key, value);
        break;
      case double:
        _preferences?.setDouble(key, value);
        break;
      case List<String>:
        _preferences?.setStringList(key, value);
        break;
    }
  }

  get({required String key}) {
    _preferences?.get(key);
  }
}
