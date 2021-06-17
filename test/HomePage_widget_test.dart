import 'package:flutter_test/flutter_test.dart';
import '../test/tools/WidgetTestTool.dart';

import 'package:web/pages/HomePage.dart';

void main() {
  final WidgetTestTool widgetTool = WidgetTestTool();

  testWidgets('Check HomePage is created', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(widgetTool.scaffoldTestWidget(HomePage()));

    // Verify that homePage is crated.
    expect(find.bySemanticsLabel('homePage'), findsOneWidget);
  });
}
