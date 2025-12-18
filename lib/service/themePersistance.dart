import 'package:shared_preferences/shared_preferences.dart';

class Themepersistance {
  //store the user's saved theme in shared prfs
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool('isDark', isDark);
    print('Theme Stored');
  }

  //load the user's saved theme from shared prefs
  Future<bool> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('Theme loaded');
    return preferences.getBool('isDark') ?? false;
  }
}
