import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4A90E2), // Sky Blue
      secondary: Color(0xFF7ED321), // White
      surface: Color(0xFFF7F7F7), // Light Gray
      error: Color(0xFFD0021B), // Light Red
      onPrimary: Colors.white,
      onSecondary: Colors.white, // Charcoal Black
      onSurface: Color(0xFF666666), // Dark Gray
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardColor: const Color(0xFFF7F7F7),
    dividerColor: const Color(0xFFE1E1E1),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF333333)),
      bodyMedium: TextStyle(color: Color(0xFF333333)),
      bodySmall: TextStyle(color: Color(0xFF666666)),
      titleLarge:
          TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Color(0xFF666666)),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFFF7F7F7),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE1E1E1)),
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF529FF5), // Electric Blue
      secondary: Color(0xFF86E01E), // Dark Charcoal
      surface: Color(0xFF2A2A2A), // Deep Gray
      error: Color(0xFFFF4D4F), // Crimson Red
      onPrimary: Colors.white,
      onSecondary: Colors.white, // White Smoke
      onSurface: Color(0xFFB0B0B0), // Light Gray
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    cardColor: const Color(0xFF2A2A2A),
    dividerColor: const Color(0xFF3E3E3E),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFEAEAEA)),
      bodyMedium: TextStyle(color: Color(0xFFEAEAEA)),
      bodySmall: TextStyle(color: Color(0xFFB0B0B0)),
      titleLarge:
          TextStyle(color: Color(0xFFEAEAEA), fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(color: Color(0xFFEAEAEA), fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Color(0xFFB0B0B0)),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFF2A2A2A),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3E3E3E)),
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF529FF5),
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
