import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_resume_app/config/theme.dart';
import 'package:my_resume_app/screen/home_screen.dart';
import 'package:my_resume_app/services/analytics_service.dart';
import 'package:my_resume_app/services/prefs_service.dart';

/// Follows the system theme until the visitor picks one with the toggle.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

/// Completes once Firebase has started up. Anything that talks to Firebase
/// should await this instead of assuming the app is already connected.
final Future<void> firebaseReady = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
).then((_) {}, onError: (Object e) {
  debugPrint('Firebase init failed: $e');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // Read the saved theme before the first frame, so the page does not flash
  // the wrong theme. This is a local read and is fast.
  final savedTheme = await PrefsService.loadThemeMode();
  if (savedTheme != null) themeNotifier.value = savedTheme;
  // Firebase is only needed for the visitor counter, so we do not block the
  // first frame on it. It keeps warming up in the background.
  runApp(const MyApp());
  AnalyticsService.logPortfolioView();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Route<void> _homeRoute() =>
      MaterialPageRoute(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // LayoutBuilder so the theme is rebuilt with the new width whenever the
        // browser window is resized.
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, currentMode, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Parth Prajapati | Resume',
                  theme: AppTheme.light(width),
                  darkTheme: AppTheme.dark(width),
                  themeMode: currentMode,
                  // There is only one page. Section links like
                  // /#/?section=projects must still open it, not report an
                  // unknown route, so every route name builds the home page.
                  onGenerateRoute: (_) => _homeRoute(),
                  onGenerateInitialRoutes: (_) => [_homeRoute()],
                );
              },
            );
          },
        );
      },
    );
  }
}
