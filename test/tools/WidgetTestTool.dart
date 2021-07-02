import 'package:flutter/material.dart';

class WidgetTestTool {
  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [MaterialApp].
  Widget materialTestWidget(Widget child) {
    return MediaQuery(data: MediaQueryData(size: Size(1440, 1080)), child: MaterialApp(home: child));
  }

  ///  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [Scaffold].
  Widget scaffoldTestWidget(Widget child) {
    return materialTestWidget(Scaffold(body: child));
  }
}