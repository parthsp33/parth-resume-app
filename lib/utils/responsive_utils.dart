import 'package:flutter/material.dart';

/// Sizing rules for this app.
///
/// The app uses `flutter_screenutil` with a 1440x900 design size. That makes
/// `.w` / `.h` scale linearly off a desktop mock, so on a 390px phone `40.w`
/// collapses to about 11px. Do not use `.w` or `.h` for layout.
///
///   * Spacing, padding, widths, heights -> plain pixels from the helpers below.
///   * Font sizes -> `context.fontSize(...)`, or `.sp` where a value is already
///     tuned and only used on desktop.
///   * Radii -> plain pixels. A 16px corner should be 16px everywhere.
class Breakpoints {
  /// Narrow phones (iPhone SE and similar).
  static const double smallMobile = 360;

  /// Below this width the layout is single column.
  static const double mobile = 650;

  /// Below this width the horizontal nav is replaced by the drawer.
  static const double compactNav = 900;

  /// At or above this width the full desktop layout is used.
  static const double tablet = 1100;

  /// Reading width cap so text does not stretch across ultra-wide monitors.
  static const double maxContentWidth = 1200;

  static bool isSmallMobileWidth(double width) => width < smallMobile;
  static bool isMobileWidth(double width) => width < mobile;
  static bool isTabletWidth(double width) => width >= mobile && width < tablet;
  static bool isDesktopWidth(double width) => width >= tablet;
}

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  bool get isSmallMobile => Breakpoints.isSmallMobileWidth(screenWidth);
  bool get isMobile => Breakpoints.isMobileWidth(screenWidth);
  bool get isTablet => Breakpoints.isTabletWidth(screenWidth);
  bool get isDesktop => Breakpoints.isDesktopWidth(screenWidth);

  /// True when the horizontal nav row no longer fits and the drawer is used.
  bool get useCompactNav => screenWidth < Breakpoints.compactNav;

  /// Picks a value for the current width tier, falling back downward.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }

  /// Horizontal page gutter. One place decides this for the whole page.
  double get gutter => responsiveValue(
        mobile: isSmallMobile ? 16.0 : 20.0,
        tablet: 40.0,
        desktop: 64.0,
      );

  /// Vertical gap between page sections.
  double get sectionGap => responsiveValue(
        mobile: 72.0,
        tablet: 96.0,
        desktop: 128.0,
      );

  /// Gap between a section heading and its body.
  double get headingGap => responsiveValue(
        mobile: 32.0,
        tablet: 48.0,
        desktop: 64.0,
      );

  /// A spacing value in real pixels, scaled modestly per tier.
  /// Pass the desktop value; phones get a slightly tighter version.
  double space(double desktopValue) => responsiveValue(
        mobile: desktopValue * 0.7,
        tablet: desktopValue * 0.85,
        desktop: desktopValue,
      );

  /// A font size in real pixels for the current tier.
  double fontSize({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    // Narrow phones get a small extra reduction so headings do not overflow.
    return isSmallMobile ? value * 0.85 : value;
  }
}
