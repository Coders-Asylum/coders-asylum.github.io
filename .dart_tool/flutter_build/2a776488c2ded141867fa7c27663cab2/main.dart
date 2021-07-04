// @dart=2.12

import 'dart:ui' as ui;

import 'package:web/main.dart' as entrypoint;

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  entrypoint.main();
}
