// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTheme {
  static String? fontFamily = GoogleFonts
      .fugazOne()
      .fontFamily;

  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.secondary),
      primaryColor: ColorManager.secondary,
      useMaterial3: true,
      scaffoldBackgroundColor: ColorManager.scaffoldBG,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.primary,
        elevation: 4,
        iconTheme: IconThemeData(color: ColorManager.secondary),
        titleTextStyle: TextStyle(
          color: ColorManager.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      fontFamily: fontFamily,
    );
  }
}
