import 'package:flutter/material.dart' show Stack, Positioned, MaterialApp, Container, Text;
import 'package:flutter_test/flutter_test.dart';
import 'package:web/components/SideBar.dart' show SideBar;
import '../tools/WidgetTestTool.dart' show WidgetTestTool;

void main() {
  WidgetTestTool tool = WidgetTestTool();

  group('Side bar smoke tests', () {
    testWidgets('Side bar widget creation test', (WidgetTester tester) async {
      await tester.pumpWidget(tool.buildTestApp(SideBar(verticalHeight: 1440, verticalWidth: 40, children: [])));
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('sidebar'), findsOneWidget);
    });

    testWidgets('Side bar Smoke test left positioned in stack', (WidgetTester tester) async {
      MaterialApp _buildApp = tool.buildTestApp(
        Stack(
          children: [Positioned(top: 0.0, left: 0.0, child: SideBar(verticalHeight: 1440, verticalWidth: 40, children: []))],
        ),
      );
      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('sidebar'), findsOneWidget);
    });

    testWidgets('Side bar Smoke test left positioned in stack', (WidgetTester tester) async {
      MaterialApp _buildApp = tool.buildTestApp(
        Stack(
          children: [Positioned(top: 0.0, right: 0.0, child: SideBar(verticalHeight: 1440, verticalWidth: 40, children: []))],
        ),
      );
      await tester.pumpWidget(_buildApp);
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('sidebar'), findsOneWidget);
    });
  });

  testWidgets('Side bar child widget test', (WidgetTester tester) async {
    MaterialApp _buildApp = tool.buildTestApp(
      Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            child: SideBar(
              verticalHeight: 1440,
              verticalWidth: 40,
              children: [
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 1')),
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 2')),
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 3')),
              ],
            ),
          )
        ],
      ),
    );

    await tester.pumpWidget(_buildApp);
    await tester.pumpAndSettle();

    expect(find.text('Child 1'), findsOneWidget);
    expect(find.text('Child 2'), findsOneWidget);
    expect(find.text('Child 3'), findsOneWidget);
  });

  testWidgets('Side bar child widget test with flip:true', (WidgetTester tester) async {
    MaterialApp _buildApp = tool.buildTestApp(
      Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            child: SideBar(
              verticalHeight: 1440,
              verticalWidth: 40,
              flip: true,
              children: [
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 1')),
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 2')),
                Container(height: 40.0, width: 1440 / 3, child: Text('Child 3')),
              ],
            ),
          )
        ],
      ),
    );

    await tester.pumpWidget(_buildApp);
    await tester.pumpAndSettle();

    expect(find.text('Child 1'), findsOneWidget);
    expect(find.text('Child 2'), findsOneWidget);
    expect(find.text('Child 3'), findsOneWidget);
  });
}
