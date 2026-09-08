import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_resume_app/config/theme.dart';
import 'package:my_resume_app/screen/home_screen.dart';


final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

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
  // Firebase is only needed for the visitor counter, so we do not block the
  // first frame on it. It keeps warming up in the background.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  home: const HomeScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}

