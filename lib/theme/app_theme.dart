import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AquaTheme {
  // Palette
  static const Color deepNavy = Color(0xFF0A1628);
  static const Color navyBlue = Color(0xFF0D2137);
  static const Color riverBlue = Color(0xFF1A6B8A);
  static const Color aquaGreen = Color(0xFF2EC4A0);
  static const Color safeGreen = Color(0xFF27AE60);
  static const Color warningAmber = Color(0xFFF39C12);
  static const Color dangerRed = Color(0xFFE74C3C);
  static const Color criticalRed = Color(0xFFC0392B);
  static const Color lightGray = Color(0xFFF0F4F8);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF8B9DB5);
  static const Color textBody = Color(0xFF2C3E50);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: aquaGreen,
        secondary: riverBlue,
        surface: navyBlue,
        onPrimary: deepNavy,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: deepNavy,
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          displayMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          headlineLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          headlineMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          headlineSmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          titleMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Color(0xFFB8C8D8)),
          labelLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: navyBlue,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: navyBlue,
        selectedItemColor: aquaGreen,
        unselectedItemColor: Color(0xFF4A6080),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF142030),
        selectedColor: aquaGreen.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
        side: const BorderSide(color: Color(0xFF2A4060)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static Color riskColor(String risk) {
    switch (risk.toUpperCase()) {
      case 'CRITICA':
      case 'CRÍTICA':
        return criticalRed;
      case 'ALTA':
        return dangerRed;
      case 'MEDIA':
      case 'MÉDIA':
        return warningAmber;
      case 'BAIXA':
        return safeGreen;
      default:
        return safeGreen;
    }
  }
}
