import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromARGB(255, 82, 212, 154);
  static const Color secondary = Color.fromRGBO(0, 145, 255, 1);
  static final ThemeData myTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primary,
      background: Color.fromARGB(255, 204, 204, 204),
    ),
    fontFamily: 'Releway',
    appBarTheme: const AppBarTheme(
      elevation: 10,
      color: primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primary),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primary, // Cambia el color del cursor aquí
    ),
  );
}
