import 'dart:convert' show json;

import 'package:meta/meta.dart' show visibleForTesting;

/// Holds all the metadata related to the post posted on the website.
///
class Post {
  /// id given to each post to identify them. It is an integer value.
  final int id;

  /// The date and time of the post published in UTC format.
  final DateTime timeStamp;

  /// Type of post "normal", "image_post" or "tutorial",
  /// this decides how the post is displayed to the user in the Blog Page post list tile.
  final String type;

  /// The post title of the article.
  final String title;

  /// The post subtitle of the article.
  final String? subtitle;

  /// The relative location of the md file for the current article.
  final String file;

  /// The relative location of the featured image.
  final String? featuredImage;

  /// The author id for the post.
  /// The list can contain multiple author if that is an "tutorial" type post.
  /// This id is used to fetch the author name and author image for the post.
  final List<int> authorId;

  /// If true then the post is displayed in the Featured Section of the blog page home as a featured post.
  final bool featured;

  /// List of category that the post falls under.
  final List<String>? category;

  /// List of tags for the post.
  final List<String>? tags;

  /// The number of likes received by the post.
  final int likes;

  /// Comments list for the post.
  /// The List items are of [Comments];
  final List<Comment>? comments;

  /// Comments list in a String format, which adheres to the JSON format obligated by the [Comment] class.
  /// This should follow the JSON format because then the comments can be mapped as Comment objects.
  late final String? commentsString;

  /// This contains the the post data is populated on object initialization.
  /// This is also populated when [Post.decode(details)] or [Post.mapDetails(postDetails)] constructor is used.
  late final Map<String, dynamic> postData;

  /// This describes all the post details.
  Post({
    required this.id,
    required this.timeStamp,
    this.type = "normal",
    required this.title,
    this.subtitle,
    required this.file,
    required this.featuredImage,
    this.authorId = const [0],
    this.featured = false,
    this.category,
    this.tags,
    this.likes = 0,
    this.comments,
    this.commentsString,
  }) : assert(comments == null || commentsString == null, 'Comments should be passed through any one methods.') {
    List<Comment>? _c = [];
    if (commentsString != null) {
      List<String> _l = json.decode(this.commentsString!);

      _l.forEach((e) {
        _c!.add(Comment(json.decode(e)));
      });
    } else {
      _c = this.comments;
    }

    postData = {
      "id": this.id,
      "timeStamp": this.timeStamp,
      "type": this.type,
      "title": this.title,
      "subtitle": this.subtitle,
      "file": this.file,
      "featuredImage": this.featuredImage,
      "featured": this.featured,
      "category": this.category,
      "tags": this.tags,
      "likes": this.likes,
      "comments": _c,
    };
  }

  /// Maps the details to the Post object parameters from Map variable [postDetails].
  /// This constructor is mainly used to map individual posts when they are published and correct JSON object could be generated and then appended to the metadata.
  ///
  ///
  /// *** Note: The keys in [postDetails] should be have the same name convection as the [Post] class attributes. or else the data won't be mapped to the correct attributes and null values can cause errors. ***
  Post.mapDetails(Map<String, dynamic> postDetails)
      : this(
          id: postDetails['id'],
          timeStamp: postDetails['timeStamp'],
          type: postDetails['type'],
          title: postDetails['title'],
          subtitle: postDetails['subtitle'],
          file: postDetails['file'],
          featuredImage: postDetails['featuredImage'],
          featured: postDetails['featured'],
          category: postDetails['category'],
          tags: postDetails['tags'],
          likes: postDetails['likes'],
          comments: postDetails['comments'],
        );

  /// Decodes the passed [details] string into the all the Post object fields.
  /// [details] should be a valid json object, with field names same as the class variables.
  Post.decode(String details) : this.mapDetails(json.decode(details));

  /// converts the list of comments into string
  @visibleForTesting
  List<String> generateCommentList() {
    /// variable to store all the comments as a list of
    late List<String> _l = [];

    // checks if the comment list is null or empty.
    if (this.comments == null || this.comments == []) {
      _l = [];
    } else {
      this.comments!.forEach((e) {
        _l.add(e.toString());
      });
    }
    return _l;
  }

  /// Generates a String that abides by the JSON object for a post data with all the details from the current object.
  @override
  String toString() {
    // String structure.
    return '{"id": "${this.id}","timeStamp": "${this.timeStamp}","type": "${this.type}","title": "${this.title}","subtitle": "${this.subtitle}","file": "${this.file}","featuredImage": "${this.featuredImage}","featured": ${this.featured},"authorId": ${this.authorId.toString()},"category": ${this.category.toString()},"tags": ${this.tags.toString()},"likes": ${this.likes},"comments": ${this.generateCommentList()}}';
  }
}

/// Comment class handles the all the nested comments for an [Post].
///
/// Comment class attributes can be directly initialised by passing a map variable or a JSON object to [Comment(commentString)];
/// [commentString] data is then mapped to each attributes of the comment class for the object using [encode] method.
///
///***Note: While passing a Map or JSON object to [commentString] make sure that the keys have same name as the attributes.***
///
/// Else each and every attribute can be individually specified for the Comment object by passing the values to the [Comment.define] constructor.
class Comment {
  /// The structured map for comment object.
  late final Map<String, dynamic> commentString;

  /// Unique id for the comment.
  ///
  /// This follows a numbered pattern following ':' for each level down in a [reply] for a comment.
  /// ```
  /// ie:
  /// topLevelComment: id=1, if any user replied to this then the id for [Comment] with index 0 in the list will be 1:1 and so on.
  ///
  /// Mapped var example:
  /// {
  ///  id:'1'
  ///  .
  ///  .
  ///  .
  ///  reply:[ |---- { id: '1:1', ....},
  ///          |
  ///          |---- { id: '1:2',....reply:[{ id: '1:2:1',.....},]},
  ///          |
  ///          |---- { id: '1:3',...},
  ///        ]
  ///  }
  /// ```
  late final String id;

  /// The date time when the comment was posted.
  late final DateTime timeStamp;

  /// Name of the author that penned the comment.
  late final String? name;

  /// The comment that is penned.
  late final String comment;

  /// Any flags given by the moderator, post author or any bot.
  /// This is used to give special characters to the comment or used to remove the comment.
  late final List<dynamic>? flags;

  /// The [Comment] reply for the original comment.
  late final List<Comment>? reply;

  /// The passed [commentString] is passed to the respective attributes of the [Comment] object.
  Comment(this.commentString) {
    this.encode(commentString);
  }

  /// All the attributes for the [Comment] object can be defined individually.
  ///
  /// After constructing the object by this method the [commentString] is also populated using the attributes.
  Comment.define({required this.id, required this.timeStamp, this.name = 'Anonymous Yoda', required this.comment, this.flags, this.reply}) {
    late List<String> _l = [];

    this.reply!.forEach((c) {
      _l.add(c.toString());
    });

    this.commentString = {"id": this.id, "name": this.name, "timeStamp": this.timeStamp.toUtc().toString(), "comment": this.comment, "flags": this.flags, "reply": _l};
  }

  /// This takes in [source] which is a map structure and then individually populates all the class attributes.
  ///
  /// This method runs recursively to decode the [reply] for each Comment object until the [reply] is an empty list or a null value.
  @visibleForTesting
  void encode(Map<String, dynamic> source) {
    // checks if reply key has a null or empty list.
    if (source['reply'] == null || source['reply'] == List.empty()) {
      this.id = source['id'];
      this.timeStamp = DateTime.parse(source['timeStamp']);
      this.name = source['name'];
      this.comment = source['comment'];
      this.flags = source['flags'];
      this.reply = [];
    } else {
      // temp variable to store the reply list.
      List<dynamic> _l = source['reply'];
      // Comment list definition.
      late List<Comment> _cList = [];

      // creates a comment object for each map in the list.
      // Then the comment object is appended.
      _l.forEach((e) {
        Comment c = Comment(e);
        _cList.add(c);
      });

      this.id = source['id'];
      this.timeStamp = DateTime.parse(source['timeStamp']);
      this.name = source['name'];
      this.comment = source['comment'];
      this.flags = source['flags'];
      this.reply = _cList;
    }
  }

  /// Converts the attributes to String and also follows a JSON object structure for the [Comment] class.
  /// todo:@maverick099 use json.encode instead of manually specifying the json structure in the toString method.
  @override
  String toString() {
    if (this.reply == null || this.reply == []) {
      return '{"id":"${this.id}","name":"${this.name}","timeStamp":"${this.timeStamp}","comment":"${this.comment}","flags":${json.encode(this.flags)},"reply":[]}';
    } else {
      List<String> r = [];
      this.reply!.forEach((element) {
        r.add(element.toString());
      });
      return '{"id":"${this.id}","name":"${this.name}","timeStamp":"${this.timeStamp}","comment":"${this.comment}","flags":${json.encode(this.flags)},"reply":${r.toString()}}';
    }
  }
}
