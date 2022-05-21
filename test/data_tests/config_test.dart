import 'package:flutter_test/flutter_test.dart';
import 'package:web/data/config.dart';
import 'package:flutter/material.dart' show Color, ThemeData;

void main() {
  group('Config data class tests', () {
    // Config object.
    final Config config = Config();
    test('Data runtime type test', () {
      expect(config.primaryColor.runtimeType, Color);
      expect(config.secondaryColor.runtimeType, Color);
      expect(config.highlightColor.runtimeType, Color);
      expect(config.shadowColor.runtimeType, Color);
      expect(config.blogPostContentFileName.runtimeType, String);
    }, tags: 'data_class_test');
  });

  group('AppThemeConfig data class tests', () {
    // test class object.
    final AppThemeConfig appThemeConfig = AppThemeConfig();
    test('Data runtime type tests', () {
      expect(
        appThemeConfig.theme.runtimeType, ThemeData);
    });
  });
}
