import 'package:flutter/material.dart';

class WidgetTestTool {
  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [MaterialApp].
  /// [screenSize] is used to specify a custom screen size to test the app in.
  Widget mediaQueryTestWidget(Widget child, {Size screenSize = const Size(1440, 1080)}) {
    return MediaQuery(data: MediaQueryData(size: screenSize), child: MaterialApp(home: child));
  }

  ///  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [Scaffold].
  Widget scaffoldTestWidget(Widget child) {
    return mediaQueryTestWidget(Scaffold(body: child));
  }

  /// Material app to test larger multifunctional widgets and pages.
  ///
  MaterialApp buildTestApp(Widget child) {
    return MaterialApp(
      home: scaffoldTestWidget(child),
    );
  }
}
