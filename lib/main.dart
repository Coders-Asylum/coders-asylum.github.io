import 'package:flutter/material.dart';
import 'package:web/pages/HomePage.dart' show HomePage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// [appTheme] contains all the default theme colors for the application.
    final ThemeData appTheme = ThemeData(
      primaryColor: Color(0xffD3D3D3),
      highlightColor: Color(0xff727272),
      backgroundColor: Color(0xff1E1E1E),
      shadowColor: Color(0xff000000),
    );

    return MaterialApp(
      title: 'Flutter 101',
      debugShowCheckedModeBanner: false,
      theme: appTheme.copyWith(colorScheme: appTheme.colorScheme.copyWith(secondary: Color(0xff1366C8))),
      home: HomePage(),
    );
  }
}
