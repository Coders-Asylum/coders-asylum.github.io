import 'package:flutter/material.dart' show Color, ThemeData;

/// Application Configuration.
///
/// This is top level App configuration. All other configuration are derived from this.
class Config {
  /// primary color
  static const Color _primaryColor = const Color(0xffD3D3D3);

  /// Highlight color.
  static const Color _highlightColor = const Color(0xff727272);

  /// Background Color.
  static const Color _backgroundColor = const Color(0xff1E1E1E);

  /// Shadow Color.
  static const Color _shadowColor = const Color(0xff000000);

  /// Secondary color.
  static const Color _secondaryColor = const Color(0xff1366C8);

  /// Blog post filename.
  static const String _blogPostContentsFileName = 'post.md';

  /// Blog post content markdown file name.
  String get blogPostContentFileName => _blogPostContentsFileName;

  /// App Primary Color.
  Color get primaryColor => _primaryColor;

  /// App Highlight Color.
  Color get highlightColor => _highlightColor;

  /// /// App Background Color.
  Color get backgroundColor => _backgroundColor;

  /// App Shadow Color.
  Color get shadowColor => _shadowColor;

  /// App Secondary/Accent color.
  Color get secondaryColor => _secondaryColor;
}

/// Application theme configuration.
class AppThemeConfig extends Config {

  /// Theme of the app.
  late final ThemeData _theme;

  AppThemeConfig() {
    this._theme = ThemeData(
        primaryColor: super.primaryColor,
        highlightColor: super.secondaryColor,
        backgroundColor: super.backgroundColor,
        shadowColor: super.shadowColor);
  }

  /// Primary theme for the app.
  ThemeData get theme => this._theme;
}
