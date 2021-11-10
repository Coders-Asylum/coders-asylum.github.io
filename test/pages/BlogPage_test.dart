import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Center, MaterialApp, Size;
import 'package:web/pages/BlogPage.dart';
import '../tools/WidgetTestTool.dart' show WidgetTestTool;

void main() {
  final WidgetTestTool tool = WidgetTestTool();

  testWidgets('BlogPage smoke test', (WidgetTester tester) async {
    MaterialApp _buildApp = tool.buildTestApp(BlogPage());

    await tester.pumpWidget(_buildApp);
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('blogPostsPage'), findsOneWidget);
  }, skip: true);

  group('FeaturedTile tests', () {
    testWidgets('Featured tile smoke test', (WidgetTester tester) async {
      final Size _screenSize = Size(1440, 1080);
      MaterialApp _buildApp = tool.buildTestApp(Center(
          child: FeaturedTile(
        screenSize: _screenSize,
      )));

      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('featuredPost'), findsOneWidget);
    }, skip: true);

    /// todo:
  });
}
