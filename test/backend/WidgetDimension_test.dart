import 'package:flutter/material.dart' show EdgeInsets;
import 'package:flutter_test/flutter_test.dart';
import 'package:web/backend/WidgetDimension.dart';

void main() {
  group('WidgetDimension tests', () {
    test('WidgetDimension constructor with default values test', () async {
      /// WidgetDimension instance.
      final WidgetDimension widgetDimension = WidgetDimension();

      expect(0.0, widgetDimension.width);
      expect(0.0, widgetDimension.height);
      expect(EdgeInsets.zero, widgetDimension.padding);
      expect(EdgeInsets.zero, widgetDimension.margin);
    });

    test('WidgetDimension constructor with all values defined  test', () async {
      /// WidgetDimension instance.
      final WidgetDimension widgetDimension = WidgetDimension(height: 123.0, width: 456.0, margin: EdgeInsets.all(8.0), padding: EdgeInsets.all(16.0));

      expect(123.0, widgetDimension.height);
      expect(456.0, widgetDimension.width);
      expect(EdgeInsets.all(16.0), widgetDimension.padding);
      expect(EdgeInsets.all(8.0), widgetDimension.margin);
    });
  });
}
