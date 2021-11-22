import 'package:flutter/material.dart' show Center, MaterialApp;
import 'package:flutter_test/flutter_test.dart';
import '../tools/WidgetTestTool.dart';
import 'package:web/components/blogPage/AllPostsTileComponents.dart';

void main() {
  WidgetTestTool tool = new WidgetTestTool();

  group('NormalPostTile tests', () {
    testWidgets('NormalPostTile smoke test', (WidgetTester tester) async {
      MaterialApp _build = tool.buildTestApp(Center(
        child: NormalPostTile(
          title: 'Test',
          authorName: 'TestAuthor',
          imageUrl: '/test/res/test_images/red.jpg',
          postDateTime: DateTime.now(),
          postLikes: 15,
          subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In non libero in ligula tincidunt vulputate.',
        ),
      ));

      await tester.pumpWidget(_build);
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('normalPost'), findsOneWidget);
    });
  });
}
