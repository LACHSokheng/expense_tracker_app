import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      // Added const for AppBarTheme
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // Added const
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
    ),
    // --- CORRECTED THIS LINE ---
    cardTheme: CardThemeData(
      // Use CardThemeData here
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.grey[700]),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[600]),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.deepPurple.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2,
        ), // Added const
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.deepPurple.shade100),
      ),
      labelStyle: TextStyle(color: Colors.grey[600]),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
  );
}
