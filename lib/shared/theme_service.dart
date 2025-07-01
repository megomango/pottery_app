import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String themeKey = 'isDarkMode';

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false; // القيمة الافتراضية Light Mode
  }
}
