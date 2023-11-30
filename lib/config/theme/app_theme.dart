import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
final class AppTheme {
  const AppTheme();

  ThemeData get themeData {
    return ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            wordSpacing: 2,
            color: Colors.black,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 16,
            wordSpacing: 2,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodySmall: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            wordSpacing: 2,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.mulish(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            wordSpacing: 2,
            color: Colors.black,
          ),
          titleLarge: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            wordSpacing: 2,
            color: Colors.black,
          ),
          labelMedium: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            wordSpacing: 2,
            color: Colors.black,
          ),
          displayMedium: GoogleFonts.montserrat(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            wordSpacing: 2,
            color: Colors.black,
          ),
          displayLarge: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            wordSpacing: 2,
            color: Colors.black,
          ),
        ));
  }
}
