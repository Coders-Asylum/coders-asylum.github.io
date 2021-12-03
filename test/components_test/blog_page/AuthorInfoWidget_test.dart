import 'package:flutter/material.dart' show Center, Icons, Key, MaterialApp;
import 'package:flutter_test/flutter_test.dart';
import '../../tools/WidgetTestTool.dart' show WidgetTestTool;
import 'package:web/components/blogPage/AuthorInfoWidget.dart';

void main() {
  final WidgetTestTool tool = WidgetTestTool();

  /// Key for widget
  Key _key = Key('testWidget');

  /// build for widget.
  final MaterialApp _build = tool.buildTestApp(Center(
      child: AuthorPostInfoMiniatureWidget(
        height: 60.0,
        width: 400.0,
        key: _key,
        postLikes: 22,
        postDateTime: DateTime.now(),
        authorName: "Test Author",
      )));

  // tests
  group('AuthorPostInfoMiniatureWidget tests', () {
    //smoke test.
    testWidgets('AuthorInfoWidget smoke test', (tester) async {

      await tester.pumpWidget(_build);
      await tester.pumpAndSettle();

      expect(find.byKey(_key), findsOneWidget);
    });

    // test details
    group('AuthorPostInfoMiniatureWidget details test', (){

      //test author name.
      /// todo: check for author name text finder in testing.
      testWidgets('AuthorPostInfoMiniatureWidget author name test', (tester)async {

        await tester.pumpWidget(_build);
        await tester.pumpAndSettle();

        expect(find.text('Test Author'),findsWidgets);
      },skip: true);

      //test like icon.
      testWidgets('AuthorPostInfoMiniatureWidget author name test', (tester)async {

        await tester.pumpWidget(_build);
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.thumb_up),findsWidgets);
      });
    });


    // divider widget test.
    /// todo: widget error  popping as defunct (no state found).
    testWidgets('divider smoke test',(tester )async{

      final MaterialApp _build = tool.buildTestApp(Center(child: testVerticalDivider()));

      await tester.pumpWidget(_build);
      await tester.pumpAndSettle();


      expect(find.byWidget(_build),findsOneWidget);

    },skip: true);

  });
}
