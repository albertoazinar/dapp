import 'dart:ui';

import 'package:despensa/utils/sharedPreferences.dart';
import 'package:flutter/material.dart';

List<Color> shadesOfGrey = [
  Color.fromRGBO(112, 128, 144, 1.0),
  Color.fromRGBO(126, 140, 155, 1.0),
  Color.fromRGBO(140, 153, 166, 1.0)
];

class ThemeChanger with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  late ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    UserState.readTheme('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    UserState.saveTheme('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    UserState.saveTheme('themeMode', 'light');
    notifyListeners();
  }
}
