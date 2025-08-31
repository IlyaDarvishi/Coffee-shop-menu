import 'package:flutter/material.dart';

/// تم تاریک برنامه
ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFB68973),
    onPrimary: Colors.white,
    secondary: Color(0xFFEABF9F),
    onSecondary: Color(0xFF1E212D),
    tertiary: Color(0xFF272727),
    onTertiary: Colors.white,
    background: Color(0xFF1E212D),
    onBackground: Colors.white,
    surface: Color(0xFF1E212D),
    onSurface: Colors.white,
  ),
);
