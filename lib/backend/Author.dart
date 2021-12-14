import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:meta/meta.dart' show visibleForTesting;

/// Author class to hold author data.
///
/// All the author information is extracted from public Github user information.
class Author {
  /// Unique id for author.
  final String id;

  /// Author name
  late final String name;

  /// Author profile image url from github.
  late final String imageURL;

  /// Bio of the user as per github profile.
  late final String bio;

  /// Github user profile url.
  late final String githubURL;

  /// Type of author, member, contributor, moderator or administrator.
  ///
  /// member: new user with less than 10 posts.
  /// contributor: user who have contributed to source code/ repo or who have more than 10 posts posted.
  /// moderator: user assigned by administrators as repo mods.
  /// administrator: Users who maintain website, repo and community.
  late final String type;

  /// Github user id.
  late final String userId;

  /// Number of followers on Github.
  late final int followers;

  /// Number of following on Github.
  late final int following;

  /// Twitter handle of the Github user.
  late final String twitterURL;

  Author(this.id) {
    final Map jsonData = jsonDecode(this.stringWithoutControlChar(jsonDataString));
    authorDetails(jsonData[this.id]);
  }

  /// Updates the attributes using the author id.
  @visibleForTesting
  void authorDetails(Map data) {
    this.name = data['name'];
    this.imageURL = data['profileImage'];
    this.bio = data['bio'];
    this.githubURL = data['url'];
    this.type = data['type'];
    this.userId = data['login'];
    this.followers = data['followers'];
    this.following = data['following'];
    this.twitterURL = data['twitter_url'] == null ? "null" : data['twitter_url'];
  }

  /// Returns the passed string with control characters escaped with those control characters.
  /// So that it can be added to a JSON string without causing any errors.
  // go on adding new escape character inside the functions and update the test string respectively.
  @visibleForTesting
  String stringWithoutControlChar(String s) {
    s = s.replaceAll("\r\n", " ");
    s = s.replaceAll('\n', ' ');
    return s;
  }

  @override
  String toString() {
    Map<String, dynamic> author = {
      "${this.id}": {
        "name": this.name,
        "type": this.type,
        "user_id": this.userId,
        "bio": this.bio,
        "github_url": this.githubURL,
        "image_url": this.imageURL,
        "followers": this.followers,
        "following": this.following,
        "twitter_url": this.twitterURL == 'null' ? null : this.twitterURL
      }
    };
    return jsonEncode(author);
  }
}

/// todo(@Maverick099): remove this and author details should come from authors.metadata file.
@visibleForTesting
const String jsonDataString = ''' 
{
  "1":{
  "login": "Maverick099",
  "profileImage": "https://avatars.githubusercontent.com/u/32545664?v=4",
  "url": "https://github.com/Maverick099",
  "type": "administrator",
  "name": "Adithya Shetty",
  "bio": "Creator Doer Tinkrer\n\r\nChief @Coders-Asylum \r\n\r\n",
  "twitter_username": null,
  "followers": 6,
  "following": 6,
  "created_at": "2017-10-05T14:03:28Z"
  }
}
''';
