import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme = ThemeData.dark();
  // Typography defaultTypography;
  late SharedPreferences prefs;
  late bool isD = true;

  ThemeData dark = ThemeData(
      //brightness: Brightness.dark,
      scaffoldBackgroundColor: Color.fromARGB(220, 6, 22, 20),
      primaryColor: Color.fromARGB(255, 160, 210, 180),
      primaryColorDark: Color.fromARGB(255, 125, 140, 100),
      primaryColorLight: Colors.white,
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        //backgroundColor: Color.fromARGB(255, 160, 198, 168),
        color: Color.fromARGB(255, 160, 198, 168),
        foregroundColor: Color.fromARGB(255, 160, 198, 168),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green));

  ThemeData light = ThemeData(
      //brightness: Brightness.light,
      scaffoldBackgroundColor: Color.fromARGB(255, 229, 228, 223),
      primaryColor: Color.fromARGB(255, 160, 198, 168),
      primaryColorDark: Color.fromARGB(255, 125, 140, 100),
      primaryColorLight: Colors.brown,
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.brown)),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        //backgroundColor: Color.fromARGB(255, 160, 198, 168),
        color: Color.fromARGB(255, 160, 198, 168),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green));

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("darkTheme", false);
      isD = true;
    } else {
      _selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
      isD = false;
    }

    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
  bool getBool() => isD;
}
