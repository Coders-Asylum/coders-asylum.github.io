import 'package:web/backend/Article.dart' show Post;
import 'package:web/backend/Author.dart' show Author;

/// Service class for AllPostsTileComponent.
class BlogPageService {
  /// Returns List of [Post] objects generated from list of Map data.
  List<Post> generatePostList(List<dynamic> list) {
    late List<Post> _postList = [];
    list.forEach((data) {
      _postList.add(Post.mapDetails(data));
    });
    return _postList;
  }

  /// Generates a single string from list of Author [ids].
  String generateAuthorName(List<dynamic> ids) {
    String _s = '';
    ids.forEach((id) {
      Author a = new Author(id.toString());
      _s += '${a.userId} ';
    });

    return _s;
  }
}
