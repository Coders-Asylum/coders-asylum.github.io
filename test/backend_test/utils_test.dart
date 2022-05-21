import 'package:flutter_test/flutter_test.dart';
import 'package:web/backend/utils.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/utils_test.mocks.dart';

@GenerateMocks([DateTime])
void main() {
  // Object creation
  final Utilities utilities = Utilities();
  
  // Current DateTIme in UTC
  final DateTime dateTimeInUTC = DateTime.parse('2022-05-21T15:56:27Z').toUtc();

  group('postDateTime tests', () {
    test('Test for less than 23 hours delay.', () {
      final DateTime twentyThreeHrsAhead = dateTimeInUTC.add(Duration(hours: 23));
      final Duration difference = twentyThreeHrsAhead.difference(dateTimeInUTC);
      final expectedString = '${difference.inHours} hours before.';

      final actualString = Utilities.postDateTime(twentyThreeHrsAhead, dateTimeInUTC);

      expect(actualString, expectedString);
    });

      test('Test for 60 less than minutes delay.', () {
      final DateTime someMinutesAhead = dateTimeInUTC.add(Duration(minutes: 59));
      final Duration difference = someMinutesAhead.difference(dateTimeInUTC);
      final expectedString = '${difference.inMinutes} minutes before.';

      final actualString = Utilities.postDateTime(someMinutesAhead, dateTimeInUTC);

      expect(actualString, expectedString);
    });


    test('Test for under 5 minutes delay.', () {
      final DateTime  under5MinutesDelay = dateTimeInUTC.add(Duration(minutes: 5));
      
      final expectedString = 'just now.';
      final actualString = Utilities.postDateTime(under5MinutesDelay, dateTimeInUTC);

      expect(actualString, expectedString);
    });

    test('Test for more than a day delay.', () {
      final DateTime  moreThanADay = dateTimeInUTC.add(Duration(days: 1));
      final expectedString = '${DateFormat(DateFormat.MONTH).format(moreThanADay)} ${moreThanADay.day}, ${moreThanADay.year}';
      final actualString = Utilities.postDateTime(moreThanADay, dateTimeInUTC);

      expect(actualString, expectedString);
    });    
  });
}
