import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({required this.isDarkMode});

  ThemeData theme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.red[500],
      brightness: (isDarkMode) ? Brightness.dark : Brightness.light);

  AppTheme copyWith({bool? isDarkMode}) =>
      AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}
