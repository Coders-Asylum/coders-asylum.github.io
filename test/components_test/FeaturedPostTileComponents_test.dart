import 'package:flutter/material.dart' show EdgeInsets, ScrollController, Size;
import 'package:flutter_test/flutter_test.dart';
import 'package:web/components/blogPage/FeaturedPostTileComponents.dart';

import '../tools/WidgetTestTool.dart';

void main() {
  /// tool that provides a wrapper for testing individual widgets.
  final WidgetTestTool tool = WidgetTestTool();

  /// [FeaturedPostInfoState] object.
  final FeaturedPostInfoState featuredPostInfoState = FeaturedPostInfoState();

  /// test scroll controller.
  final ScrollController scrollController = ScrollController();

  /// test list of [FeaturedPost] with maximum/all info.
  const List<FeaturedPost> testFeaturedPost = [
    FeaturedPost('post1', ['test_topic_1'], ['test_tag_1.1', 'test_tag_1.2', 'test_tag_1.3'], '/test/res/test_images/red.jpg', 'test_author_1'),
    FeaturedPost('post2', ['test_topic_1'], ['test_tag_2.1', 'test_tag_2.2', 'test_tag_2.3'], '/test/res/test_images/green.jpg', 'test_author_2'),
    FeaturedPost('post2', ['test_topic_1'], ['test_tag_3.1', 'test_tag_3.2', 'test_tag_3.3'], '/test/res/test_images/blue.jpg', 'test_author_3'),
  ];

  // smoke test to see if the widget builds without any errors using [_featurePost] or similar list.
  group('FeaturedPostTileComponents smoke test', () {
    //test 1: Featured Post Info
    testWidgets('FeaturedPostInfo single featured post smoke test (minimal info)', (WidgetTester _t) async {
      /// testing with a single minimum [Topic] and tag parameters for smoke test
      const List<FeaturedPost> smokeTestFeaturedPost = [
        FeaturedPost('post1', ['test_topic_1'], ['test_tag_1'], '/test/res/test_images/red.jpg', 'test_author_1')
      ];

      // build the widget
      await _t.pumpWidget(tool.mediaQueryTestWidget(FeaturedPostInfo(featuredPost: smokeTestFeaturedPost[0])));
      // find the built widget
      expect(find.text(smokeTestFeaturedPost[0].title), findsOneWidget, skip: true);
    });

    // test to check if list2String conversion functions is working properly.
    test('list2String test', () {
      // test with tags = true
      expect('#test_tag_1.1 #test_tag_1.2 #test_tag_1.3 ', featuredPostInfoState.list2String(testFeaturedPost[0].tags, tags: true));

      // test with tags = false
      expect('test_tag_1.1 test_tag_1.2 test_tag_1.3 ', featuredPostInfoState.list2String(testFeaturedPost[0].tags, tags: false));

      // test for topic (single length list)
      expect('test_topic_1 ', featuredPostInfoState.list2String(testFeaturedPost[0].topics, tags: false));
    });

    // test 1.1: FeaturedPostInfo
    testWidgets('FeaturedPostInfo multi featured post smoke test', (WidgetTester _t) async {
      // loops through the test feature post list, building the feature post for each list item.
      for (int i = 0; i < testFeaturedPost.length; i++) {
        // build widget
        await _t.pumpWidget(tool.mediaQueryTestWidget(FeaturedPostInfo(featuredPost: testFeaturedPost[i])));
        expect(find.byWidget(FeaturedPostInfo(featuredPost: testFeaturedPost[i])), findsOneWidget, skip: true);
      }
    });

    // test 2 : FeaturedTilePostNavButton
    testWidgets('FeaturedTilePostNavButton smoke test', (WidgetTester _t) async {
      // build widget with direction as NavDirection forward
      await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavButton(direction: NavDirection.forward, scrollController: scrollController, scrollFunction: (d) {})));
      expect(find.bySemanticsLabel('Navigation Button'), findsOneWidget);

      // build widget with direction as NavDirection backward
      await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavButton(direction: NavDirection.backward, scrollController: scrollController, scrollFunction: (d) {})));
      expect(find.bySemanticsLabel('Navigation Button'), findsOneWidget);
    });

    // test 3 : FeaturedTilePostNavDots
    testWidgets('FeaturedTilePostNavDots smoke test', (WidgetTester _t) async {
      // build widget
      await _t.pumpWidget(tool.mediaQueryTestWidget(FeaturedPostTileNavDots(currentIndex: 0, totalPosts: testFeaturedPost.length)));

      expect(find.bySemanticsLabel('nav dots'), findsOneWidget);
    });
  });

  // Functional tests to see of the widgets change state according to the interaction and
  group('FeaturedPostTileComponents Functional test', () {
    // test 1: FeaturedTilePostNavDots
    testWidgets('FeaturedPostTileNavDots single size change test', (WidgetTester _t) async {
      /// Radius of the dots
      const double _rad = 10.0;

      /// margin after translation;
      const EdgeInsets marginT = EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0);

      /// margin without translation
      const EdgeInsets margin = EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0);

      /// The change in radius when the dot is active.
      const double _change = 5.0;

      /// Size of the translated dot
      final Size translatedSize = Size(_rad + _change + marginT.horizontal, _rad + _change + marginT.vertical);

      /// Size of non-translated dot.
      final Size size = Size(_rad + margin.horizontal, _rad + margin.vertical + 5);

      await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavDots(currentIndex: 0, totalPosts: testFeaturedPost.length)));

      /// gets the size of the translated size.
      Size sT = _t.getSize(find.bySemanticsLabel('dot 0'));
      // checks if dot zero has translated
      expect(sT, translatedSize);

      /// gets the size of the
      Size s = _t.getSize(find.bySemanticsLabel('dot 1'));
      // checks if dot 1 is not translated.
      expect(s, size);
    });

    // test 1.1: FeaturedTilePostNavDots
    testWidgets('FeaturedPostTileNavDots periodic size change test', (WidgetTester _t) async {
      /// diameter of the dots
      const double _dia = 10.0;

      /// margin after translation;
      const EdgeInsets marginT = EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0);

      /// margin without translation
      const EdgeInsets margin = EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0);

      /// The change in radius when the dot is active.
      const double _change = 5.0;

      /// Size of the translated dot
      final Size translatedSize = Size(_dia + _change + marginT.horizontal, _dia + _change + marginT.vertical);

      /// Size of non-translated dot.
      final Size size = Size(_dia + margin.horizontal, _dia + margin.vertical + 5);

      // Checks if all dots are being able to translate one by one.
      // also (second for loop) checks on the active dot is translated and others are not changed
      for (int i = 0; i < testFeaturedPost.length; i++) {
        await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavDots(currentIndex: i, totalPosts: testFeaturedPost.length)));

        for (int j = 0; j < testFeaturedPost.length; j++) {
          if (i == j) {
            /// gets the size of the active dot.
            Size sT = _t.getSize(find.bySemanticsLabel('dot $i'));
            // checks if dot i==jth (active) dot has translated.
            expect(sT, translatedSize);
          } else {
            /// gets the size of the non-active dot.
            Size s = _t.getSize(find.bySemanticsLabel('dot $j'));
            // checks if dot i!=jth (non-active) dot is not translated.
            expect(s, size);
          }
        }
      }
    });

    // test 2: FeaturedTilePostTileNavButtons
    testWidgets('FeaturedPostTileNavButtons tap response test.', (WidgetTester _t) async {
      /// used to store the [direction] returned by the [scrollFunction] of the widget.
      late NavDirection direction;

      // building the widget with direction as NavDirection.forward
      await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavButton(scrollController: scrollController, scrollFunction: (d) => direction = d, direction: NavDirection.forward)));
      // taping the button
      await _t.tap(find.bySemanticsLabel('Navigation Button'));
      // check if button with NavDirection.forward after tap scrollFunction also returns NavDirection.forward
      expect(direction, NavDirection.forward);

      // building the widget with direction as NavDirection.backward
      await _t.pumpWidget(tool.scaffoldTestWidget(FeaturedPostTileNavButton(scrollController: scrollController, scrollFunction: (d) => direction = d, direction: NavDirection.backward)));
      // taping the button
      await _t.tap(find.bySemanticsLabel('Navigation Button'));
      // check if button with NavDirection.backward after tap scrollFunction also returns NavDirection.backward
      expect(direction, NavDirection.backward);
    });

    //test 3.1: Featured Post Info
    testWidgets('FeaturedPostInfo information text visibility test (minimal info)', (WidgetTester _t) async {
      /// testing with a single minimum [Topic] parameters for smoke test
      const List<FeaturedPost> smokeTestFeaturedPost = [
        FeaturedPost('post1', ['test_topic_1'], ['test_tag_1'], '/test/res/test_images/red.jpg', 'test_author_1'),
      ];

      // build widget
      await _t.pumpWidget(tool.mediaQueryTestWidget(FeaturedPostInfo(featuredPost: smokeTestFeaturedPost[0])));

      // find title
      expect(find.text(smokeTestFeaturedPost[0].title), findsWidgets, skip: true);
      // find topic
      expect(find.text(smokeTestFeaturedPost[0].topics![0]), findsWidgets, skip: true);
      // find tags
      expect(find.text('#${smokeTestFeaturedPost[0].tags![0]}'), findsWidgets, skip: true);
      // find author name
      expect(find.text(testFeaturedPost[0].author!), findsWidgets, skip: true);
    });

    // test 3.2: FeaturedPostInfo
    testWidgets('FeaturedPostInfo text visibility test.', (WidgetTester _t) async {
      // loops through the test feature post list, building the feature post for each list item.
      for (int i = 0; i < testFeaturedPost.length; i++) {
        //build widget
        await _t.pumpWidget(tool.mediaQueryTestWidget(FeaturedPostInfo(featuredPost: testFeaturedPost[i])));
        // find title
        expect(find.text(testFeaturedPost[i].title), findsWidgets, skip: true);
        // find topic
        expect(find.text(testFeaturedPost[i].topics![0]), findsWidgets, skip: true);
        // find tags
        expect(find.text('${featuredPostInfoState.list2String(testFeaturedPost[i].tags, tags: true)}'), findsWidgets, skip: true);
        // find author name
        expect(find.text(testFeaturedPost[i].author!), findsWidgets, skip: true);
      }
    });
  });
}
