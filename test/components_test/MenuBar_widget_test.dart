import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../tools/WidgetTestTool.dart';

// Testing file
import 'package:web/components/MenuBar.dart';

void main() {
  final PageController _pageController = PageController(initialPage: 0);
  final WidgetTestTool testTool = WidgetTestTool();

  //smoke test to see that the Menu bar is created inside a Scaffold.
  testWidgets('MenuBar is created', (WidgetTester tester) async {
    await tester.pumpWidget(testTool.materialTestWidget(MenuBar(pageController: _pageController)));

    expect(find.bySemanticsLabel('menuBar'), findsOneWidget);
  });

  // tests to see if menu tabs are being created.
}
