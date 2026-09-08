import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/color.dart';
import '../utils/responsive_utils.dart';

class AppTheme {
  /// Built per width rather than stored in a static field. A static field is
  /// evaluated once and cached, so text sizes would never update when the
  /// browser window is resized.
  static ThemeData light(double width) => _buildTheme(
        width: width,
        brightness: Brightness.light,
        bg: AppColors.backgroundLight,
        card: AppColors.surfaceLight,
        txtPri: AppColors.textPrimaryLight,
        txtSec: AppColors.textSecondaryLight,
      );

  static ThemeData dark(double width) => _buildTheme(
        width: width,
        brightness: Brightness.dark,
        bg: AppColors.backgroundDark,
        card: AppColors.surfaceDark,
        txtPri: AppColors.textPrimaryDark,
        txtSec: AppColors.textSecondaryDark,
      );

  /// Picks a plain pixel font size for the current width tier.
  static double _size(
    double width, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (Breakpoints.isDesktopWidth(width)) return desktop;
    if (Breakpoints.isTabletWidth(width)) return tablet;
    return Breakpoints.isSmallMobileWidth(width) ? mobile * 0.85 : mobile;
  }

  static ThemeData _buildTheme({
    required double width,
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
          fontSize: _size(width, mobile: 44, tablet: 64, desktop: 88),
          fontWeight: FontWeight.w700,
          color: txtPri,
          letterSpacing: -2,
          height: 1.0,
        ),
        // Section Headers
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: _size(width, mobile: 32, tablet: 42, desktop: 56),
          fontWeight: FontWeight.w700,
          color: txtPri,
          height: 1.1,
          letterSpacing: -1,
        ),
        // Logos / Nav Items
        displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: _size(width, mobile: 20, tablet: 22, desktop: 24),
          fontWeight: FontWeight.w700,
          color: txtPri,
          letterSpacing: 2,
        ),
        // Professional Labels (Red)
        labelLarge: GoogleFonts.inter(
          fontSize: _size(width, mobile: 13, tablet: 14, desktop: 14),
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 2.0,
        ),
        // Main Body Text
        bodyLarge: GoogleFonts.inter(
          fontSize: _size(width, mobile: 15, tablet: 16, desktop: 18),
          color: txtSec,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: _size(width, mobile: 14, tablet: 15, desktop: 16),
          color: txtSec,
          height: 1.5,
        ),
      ),
    );
  }


}