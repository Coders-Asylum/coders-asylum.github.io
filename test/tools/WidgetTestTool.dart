import 'package:flutter/material.dart';

class WidgetTestTool {
  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [MaterialApp].
  Widget scaffoldTestWidget(Widget child) {
    return MediaQuery(data: MediaQueryData(size: Size(1440, 1080)), child: MaterialApp(home: child));
  }
}
