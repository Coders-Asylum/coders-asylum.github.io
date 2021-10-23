import 'package:flutter/material.dart' show Center, MaterialApp;
import 'package:flutter_test/flutter_test.dart';
import 'package:web/components/Button.dart' show Button;
import '../tools/WidgetTestTool.dart' show WidgetTestTool;

void main() {
  WidgetTestTool tool = WidgetTestTool();

  group('Button Smoke tests', () {
    /// Builds an app with the button at center.
    final MaterialApp _buildApp = tool.buildTestApp(Center(child: Button(width: 200.0, text: 'test', height: 40.0)));

    testWidgets('Button Smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();
    });

    testWidgets('Button text smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();

      expect(find.text('test'), findsOneWidget);
    });
  });

  testWidgets('Button tap test', (WidgetTester tester) async {
    bool tap = false;
    final MaterialApp _buildApp = tool.buildTestApp(Center(child: Button(width: 200.0, text: 'test', height: 40.0, onPressed: () => tap = !tap)));

    await tester.pumpWidget(_buildApp);
    await tester.tap(find.text('test'));

    await tester.pump();

    expect(tap, isTrue);
  });
}
