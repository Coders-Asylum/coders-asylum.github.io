import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

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
}
