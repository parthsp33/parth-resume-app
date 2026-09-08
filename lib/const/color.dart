import 'package:flutter/material.dart';

class AppColors {
  // Primary Accent
  static const primary = Color(0xFFFF2D20);

  /// Same brand red, darkened for use as text on a light background.
  ///
  /// [primary] on white is about 3.7:1, under the 4.5:1 minimum for normal
  /// text. This is about 5.2:1. Use it for text and small icons in the light
  /// theme only; [primary] stays correct on the dark background and for large
  /// fills such as buttons.
  static const primaryOnLight = Color(0xFFD41F14);


  // Theme Origins
  static const backgroundDark = Color(0xFF09090B); // Midnight Black
  static const surfaceDark = Color(0xFF18181B); // Card surface
  static const textPrimaryDark = Color(0xFFFAFAFA);
  static const textSecondaryDark = Color(0xFFA1A1AA);
  
  static const backgroundLight = Color(0xFFFFFFFF);
  static const surfaceLight = Color(0xFFF4F4F5);
  static const textPrimaryLight = Color(0xFF09090B);
  static const textSecondaryLight = Color(0xFF71717A);
}