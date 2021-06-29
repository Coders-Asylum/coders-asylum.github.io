import 'package:flutter/material.dart' show Container;
import 'package:flutter_test/flutter_test.dart';
import '../tools/WidgetTestTool.dart';
import 'package:web/components/NameIconWidget.dart';

void main() {
  final WidgetTestTool tool = WidgetTestTool();

  testWidgets('NameIconWidget smoke test', (WidgetTester _t) async {
    // build widget
    await _t.pumpWidget(tool.scaffoldTestWidget(Container(height: 50.0, width: 50.0, child: NameIcon(name: 'test'))));
    // find one widget
    expect(find.text('T'), findsOneWidget);
  });
}
