import 'package:flutter/material.dart';

class WidgetTestTool {
  /// [screenSize] is used to specify a custom screen size to test the app in.
  Size _screenSize = Size(1440, 1080);

  /// Screen size for the current testing environment.
  get screenSize => this._screenSize;

  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [MaterialApp].
  Widget mediaQueryTestWidget(Widget child, {Size screenSize = const Size(1440, 1080)}) {
    this._screenSize = screenSize;
    return MediaQuery(data: MediaQueryData(size: screenSize), child: MaterialApp(home: child));
  }

  ///  /// Returns the widget passed in the [child] after wrapping it with [MediaQuery] and [Scaffold].
  Widget scaffoldTestWidget(Widget child, {Size screenSize = const Size(1440, 1080)}) {
    return mediaQueryTestWidget(Scaffold(body: child), screenSize: screenSize);
  }

  /// Material app to test larger multifunctional widgets and pages.
  ///
  MaterialApp buildTestApp(Widget child, {Size screenSize = const Size(1440, 1080)}) {
    return MaterialApp(
      home: scaffoldTestWidget(child, screenSize: screenSize),
    );
  }
}
