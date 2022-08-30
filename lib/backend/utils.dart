import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

/// Top level class to store a height and width of an entitiy.
class Dimension {
  /// Height of the entity.
  final double height;

  /// Width of the entity.
  final double width;

  const Dimension({required this.height, required this.width});
}

/// Class to store the height and width of a text string with a specific [TextStyle].
///
/// If [TextStyle] is not specified then the dimension is calculated using App default [TextStyle];
class TextDimension extends Dimension {
  final String text;
  final TextStyle? textStyle;

  TextDimension({required this.text, this.textStyle}) : super(width: 0.0, height: 0.0);

  Dimension _calculateDimension() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this.text, style: this.textStyle ?? TextStyle()),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();

    return Dimension(height: textPainter.size.height, width: textPainter.size.width);
  }
}

/// Common utility methods used in applications.
class Utilities {
  @visibleForTesting
  DateTime getCurrentDateTime() => DateTime.now();

  /// Converts the [publishDateTimInUTC] published date time in UTC to string one of below string format:
  ///
  /// - If post time is under an hour then string returned as: "**0-59 Minutes before.**".
  /// - If post time is under a day/ 24 hors then the string returned as: "**0-23 Hours before.**".
  /// - If post time does not match above conditions then the string returned as: "**Month DD, YYYY.**" format.
  static String postDateTime(DateTime publishDateTimeInUTC, [DateTime? _currentDateTime]) {
    /// Converted date time to local timezone.
    final DateTime _publishTimeInLocal = publishDateTimeInUTC.toLocal();

    /// Current date and time in local timezone.
    final DateTime _currentTime = _currentDateTime == null ? DateTime.now() : _currentDateTime;

    /// local time difference.
    final Duration difference = _publishTimeInLocal.difference(_currentTime);
    if (difference.inHours <= 23) {
      if (difference.inMinutes <= 59) {
        if (difference.inMinutes <= 5) {
          return "just now.";
        }
        return "${difference.inMinutes} minutes before.";
      }
      return "${difference.inHours} hours before.";
    }
    return '${DateFormat(DateFormat.MONTH).format(_publishTimeInLocal)} ${_publishTimeInLocal.day}, ${_publishTimeInLocal.year}';
  }

  /// Generates a single string from list of [tags] passed as parameter with a preceding `#`.
  static String tagsString(List<String> tags) {
    late String _tagsString = '';
    tags.forEach((tag) => _tagsString += '#$tag ');
    return _tagsString;
  }

  static TextDimension textHeight(String text, {TextStyle? style}) {
    final TextStyle _style = style ?? TextStyle();
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: _style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();

    final double _height = textPainter.size.height;
    final double _width = textPainter.size.width;
    print('$_height $_width');
    return TextDimension(height: _height, width: _width);
  }

  //todo: add this to utils code pack.
  /// Callucltes the required height of a [Text] widget parent [Container] or [SizedBox].
  ///
  /// This uses the [textDimension] and [parentWidth] to calculate a requrired height and then adds the [offset] to it.
  /// **The child [Text] widget should have softwrap value as true.**
  static double textContainerHeight(TextDimension textDimension, double parentWidth, {double? offset}) {
    print("$parentWidth ${textDimension.height} ${textDimension.width}");
    if (textDimension.width <= parentWidth) {
      return textDimension.height + (offset ?? 0.0);
    } else {
      return ((textDimension.width / parentWidth).ceil()) * textDimension.height + (offset ?? 0.0);
    }
  }
}
