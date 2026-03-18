// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:my_resume_app/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    // Avoid pending timers from visibility_detector in widget tests.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const MyApp());
    // Let initial flutter_animate timers elapse.
    await tester.pump(const Duration(seconds: 1));

    // A couple of high-signal strings that should exist on first build.
    expect(find.text('Portfolio'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
  });
}
