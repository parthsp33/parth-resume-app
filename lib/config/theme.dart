import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/color.dart';

class AppTheme {
  static ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    bg: AppColors.backgroundLight,
    card: AppColors.surfaceLight,
    txtPri: AppColors.textPrimaryLight,
    txtSec: AppColors.textSecondaryLight,
  );

  static ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    bg: AppColors.backgroundDark,
    card: AppColors.surfaceDark,
    txtPri: AppColors.textPrimaryDark,
    txtSec: AppColors.textSecondaryDark,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color bg,
    required Color card,
    required Color txtPri,
    required Color txtSec,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: bg,
      cardColor: card,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        surface: card,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        // Massive Name Title
        displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 88.sp,
          fontWeight: FontWeight.w700,
          color: txtPri,
          letterSpacing: -2,
          height: 1.0,
        ),
        // Section Headers
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 56.sp,
          fontWeight: FontWeight.w700,
          color: txtPri,
          height: 1.1,
          letterSpacing: -1,
        ),
        // Logos / Nav Items
        displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: txtPri,
          letterSpacing: 2,
        ),
        // Professional Labels (Red)
        labelLarge: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 2.0,
        ),
        // Main Body Text
        bodyLarge: GoogleFonts.inter(
          fontSize: 18.sp,
          color: txtSec,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16.sp,
          color: txtSec,
          height: 1.5,
        ),
      ),
    );
  }


}