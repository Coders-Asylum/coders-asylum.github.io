import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:web/data/config.dart';

void main() {
  runApp(BlogPostPageApp());
}

/// This entrypoint for Blog Post Page App
class BlogPostPageApp extends StatelessWidget {
  /// Post title for the webpage.
  late final String postTile;

  /// File contents of the post written in markdown.
  late final String fileContents;

  /// Application config.
  final Config appConfig = Config();

  BlogPostPageApp({Key? key}) : super(key: key) {
    try {
      File(Config().blogPostContentFileName).readAsString().then((String contents) => this.fileContents = contents);
    } catch (error) {
      print('Error while reading file: $error');
    }

    this.postTile = 'Post title';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog | ${this.postTile}',
      debugShowCheckedModeBanner: false,
      theme: AppThemeConfig().theme.copyWith(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: BlogPostPage(),
    );
  }
}

/// Blog Post Page UI.
class BlogPostPage extends StatefulWidget {
  BlogPostPage({Key? key}) : super(key: key);

  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config().backgroundColor,
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // title contiainer
                  Container(
                    width: MediaQuery.of(context).size.width * 0.31,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.blueAccent,
                  ),
                  // post image container
                  Container(
                    width: MediaQuery.of(context).size.width * 0.69,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.cyanAccent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Title block
///
/// Holds the post title, post category, post time stamp and post tags.
class TitleBlock extends StatefulWidget {
  /// Post title for the current post.
  final String title;

  /// List of tags for the current post.
  final List<String> tags;

  /// Category of the post for classification.
  final String category;

  /// Timestamp of post when it was published, should be in UTC format.
  final String timeStamp;

  TitleBlock({required this.title, required this.category, required this.tags, required this.timeStamp});
  _TitleBlockState createState() => _TitleBlockState();
}

class _TitleBlockState extends State<TitleBlock> {
  @override
  Widget build(BuildContext context) {
    throw(UnimplementedError());
  }
}
