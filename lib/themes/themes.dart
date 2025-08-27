import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(color: Colors.deepPurple),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(color: Colors.deepPurple),
  );
}
