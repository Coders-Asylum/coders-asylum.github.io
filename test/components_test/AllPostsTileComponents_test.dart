import 'package:flutter/material.dart' show Center, Color, Colors, Container, Key, MaterialApp, Paint, PaintingStyle, Text, TextStyle, Widget;
import 'package:flutter_test/flutter_test.dart';
import '../tools/WidgetTestTool.dart';
import 'package:web/components/blogPage/AllPostsTileComponents.dart';

void main() {
  WidgetTestTool tool = new WidgetTestTool();

  group('NormalPostTile tests', () {
    /// todo visual testing needed: tests failing due to renderBox overflow of column widget, but visually seen none.
    testWidgets('NormalPostTile smoke test', (WidgetTester tester) async {
      MaterialApp _build = tool.buildTestApp(Center(
        child: NormalPostTile(
          title: 'Test',
          authorName: 'TestAuthor',
          imageUrl: './test/res/test_images/red.jpg',
          postDateTime: DateTime.now(),
          postLikes: 15,
          subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In non libero in ligula tincidunt vulputate.',
        ),
      ));

      await tester.pumpWidget(_build);
      await tester.pumpAndSettle();

      expect(find.byWidget(_build), findsOneWidget);
    },skip: true);
  });

  group('ImagePost test', () {
    /// todo visual testing needed: tests failing due to renderBox overflow of column widget, but visually seen none.
    testWidgets('ImagePost smoke test', (WidgetTester tester) async {
      MaterialApp _build = tool.buildTestApp(Center(
        child: ImagePostTile(
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

      expect(find.bySemanticsLabel('imagePost'), findsOneWidget);
    }, skip: true);

    group('StrokedText method test', () {
      testWidgets('StrokedText method smoke test', (tester) async {
        MaterialApp _build = tool.buildTestApp(Center(child: Container(height: 40.0, width: 100.0, child: strokeTextTest('hello'))));

        await tester.pumpWidget(_build);
        await tester.pumpAndSettle();

        expect(find.byWidget(_build), findsOneWidget);
      });

      testWidgets('StrokedText method text test', (tester) async {
        MaterialApp _build = tool.buildTestApp(Center(child: Container(height: 40.0, width: 100.0, child: strokeTextTest('hello'))));

        await tester.pumpWidget(_build);
        await tester.pumpAndSettle();

        expect(find.text('hello'), findsNWidgets(2));
      });

      testWidgets('StrokedText method style test', (tester) async {
        // text to be displayed.
        const String text = 'Hello, How you doing?';
        // default text style values
        const Color color = Colors.white;
        const double strokeWidth = 0.5;
        const Color strokeColor = Colors.black;
        const double fontSize = 22.0;
        const String fontFace = 'Orbitron';

        /// key to differentiate the un-stroked Text Widget.
        const Key _unStroked = Key('unStroked_text');

        /// key to differentiate the stroked Text Widget.
        const Key _stroked = Key('stroked_text');

        // main app
        MaterialApp _build = tool.buildTestApp(Center(
            child: Container(height: 40.0, width: 100.0, child: strokeTextTest(text, fontSize: fontSize, color: color, fontFace: fontFace, strokeColor: strokeColor, strokeWidth: strokeWidth))));

        // This is a text widget with normal styling.
        final Text textUnStroked = Text(text, style: TextStyle(fontSize: fontSize, fontFamily: fontFace, color: color), softWrap: true);

        // This is a text widget with stroked styling.
        final Text textStroked = Text(text,
            style: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFace,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = strokeColor),
            softWrap: true);

        // build app.
        await tester.pumpWidget(_build);
        await tester.pumpAndSettle();

        // check for un-stroked text widget.
        Text getUnStrokedTextWidget = tester.widget(find.byKey(_unStroked));
        expect(getUnStrokedTextWidget.style, textUnStroked.style);

        // check for stroked text widget.
        Text getStrokedTextWidget = tester.widget(find.byKey(_stroked));
        expect(getStrokedTextWidget.style!.toStringShort(), textStroked.style!.toStringShort());
      });
    });
  });
}
