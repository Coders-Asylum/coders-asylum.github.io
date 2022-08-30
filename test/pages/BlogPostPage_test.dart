import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web/pages/BlogPostPage.dart';

void main() {
  group('BlogPostPage smoke tests', () {
    testWidgets('Page build smoke test', (WidgetTester tester) async {
      GlobalKey testBlogPostPageKey = GlobalKey();
      await tester.pumpWidget(BlogPostPageApp(
        key: testBlogPostPageKey,
      ));
      await tester.pumpAndSettle();
      expect(find.byKey(testBlogPostPageKey), findsOneWidget);
    });
  });
}
