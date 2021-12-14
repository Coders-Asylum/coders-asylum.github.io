import 'package:flutter_test/flutter_test.dart';
import 'package:web/backend/Author.dart';

void main() {
  group('Author class tests', () {
    const int authorId = 1;
    Author a = Author(authorId.toString());

    test('Author class ', () async {
      expect("1", a.id);
      expect("Adithya Shetty", a.name);
      expect("administrator", a.type);
      expect("Maverick099", a.userId);
      expect("https://avatars.githubusercontent.com/u/32545664?v=4", a.imageURL);
      expect("https://github.com/Maverick099", a.githubURL);
      expect("Creator Doer Tinkrer  Chief @Coders-Asylum   ", a.bio);
      expect(6, a.following);
      expect(6, a.followers);
      expect('null', a.twitterURL);
    });

    test('stringWithoutControlChar method test', () async {
      expect('Creator Doer Tinkrer  Chief @Coders-Asylum   ', a.stringWithoutControlChar('Creator Doer Tinkrer\n\r\nChief @Coders-Asylum \r\n\r\n'));
    });
  });
}

/// Author Stub class
class AuthorStub extends Author {
  @override
  final String id;

  AuthorStub(this.id) : super(id);

  @override
  String stringWithoutControlChar(String s) {
    return super.stringWithoutControlChar(s);
  }

  @override
  void authorDetails(Map data) {
    super.authorDetails(data);
  }
}
