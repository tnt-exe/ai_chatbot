import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Colors.blueAccent,
    secondary: Colors.white,
    surface: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.white,
    surface: Colors.black,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.grey,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white70,
    ),
  ),
);
