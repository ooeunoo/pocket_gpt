import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18.0),
    bodyLarge: TextStyle(fontSize: 16.0),
    bodyMedium: TextStyle(fontSize: 14.0),
    bodySmall: TextStyle(fontSize: 12.0),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.blue, brightness: Brightness.light),
);

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(fontSize: 18.0, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.grey),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.blue, brightness: Brightness.dark),
);

ThemeData getThemeData(Brightness brightness) {
  return brightness == Brightness.light ? _lightTheme : _darkTheme;
}
