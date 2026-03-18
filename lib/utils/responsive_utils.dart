
import 'package:flutter/material.dart';

class Breakpoints {
  // Keep these aligned with `ResponsiveWrapper`.
  static const double mobile = 650;
  static const double tablet = 1100;

  static bool isMobileWidth(double width) => width < mobile;
  static bool isTabletWidth(double width) => width >= mobile && width < tablet;
  static bool isDesktopWidth(double width) => width >= tablet;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isMobile => Breakpoints.isMobileWidth(screenWidth);
  bool get isTablet => Breakpoints.isTabletWidth(screenWidth);
  bool get isDesktop => Breakpoints.isDesktopWidth(screenWidth);

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Breakpoints.isMobileWidth(constraints.maxWidth)) {
          return mobileLayout;
        } else if (Breakpoints.isTabletWidth(constraints.maxWidth)) {
          return tabletLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}