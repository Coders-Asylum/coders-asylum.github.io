import 'package:flutter/material.dart' show MaterialApp, Size;
import 'package:flutter_test/flutter_test.dart';
import '../tools/WidgetTestTool.dart' show WidgetTestTool;
import 'package:web/pages/HomePage.dart';

void main() {
  final WidgetTestTool tool = WidgetTestTool();

  group('Smoke tests', () {
    /// test ignored
    testWidgets('HomePage smoke test.', (WidgetTester tester) async {
      MaterialApp _buildApp = tool.buildTestApp(HomePage(), screenSize: Size(1920, 1080));

      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('homepage'), findsOneWidget);
    }, skip: true);

    /// test ignored:
    testWidgets('HomeScreen widget smoke test.', (WidgetTester tester) async {
      MaterialApp _buildApp = tool.buildTestApp(HomeScreen());

      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('homeScreen'), findsOneWidget);
    }, skip: true, semanticsEnabled: true);
  });
}
