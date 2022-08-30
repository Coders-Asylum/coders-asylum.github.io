import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:web/backend/utils.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // title contiainer
                    Container(
                      width: MediaQuery.of(context).size.width * 0.31,
                      height: MediaQuery.of(context).size.height,
                      child: TitleBlock(
                        title: 'Lets say this a title, with test to make it a long title.',
                        category: 'Test posts',
                        tags: ['long title', 'test post', 'development'],
                        subtitle: "This is the subtitle giving a punchline to the post or a twoliner for the written post giving reader what to expect.",
                        timeStamp: DateTime.now().toUtc().toString(),
                      ),
                    ),
                    // post image container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.69,
                      height: MediaQuery.of(context).size.height,
                      child: FeatureImageBlock(),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.deepPurple,
                child: BlogContentSection(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                color: Theme.of(context).backgroundColor,
              ),
            ],
          ),
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

  /// Post title for the current post.
  final String? subtitle;

  /// List of tags for the current post.
  final List<String> tags;

  /// Category of the post for classification.
  final String category;

  /// Timestamp of post when it was published, should be in UTC format.
  final String timeStamp;

  TitleBlock({Key? key, required this.title, required this.category, required this.tags, required this.timeStamp, this.subtitle}) : super(key: key);
  _TitleBlockState createState() => _TitleBlockState();
}

class _TitleBlockState extends State<TitleBlock> {
  /// Mater level style property.
  final TextStyle _style = TextStyle(fontFamily: 'Gobold');

  /// Title text style.
  late final TextStyle _titleStyle;

  /// Subtitle text style.
  late final TextStyle _subtitleStyle;

  /// Category text style.
  late final TextStyle _categorystyle;

  /// Date text style.
  late final TextStyle _dateStyle;

  /// Tags text style.
  late final TextStyle _tagsStyle;


  @override
  void initState() {
    _titleStyle = this._style.copyWith(color: Config().primaryColor, fontSize: 48.0);
    _subtitleStyle = this._style.copyWith(color: Config().secondaryColor, fontFamily: 'Source Code', fontSize: 16.0);
    _categorystyle = this._style.copyWith(color: Config().secondaryColor, fontSize: 16.0);
    _dateStyle = this._style.copyWith(color: Config().highlightColor, fontSize: 16);
    _tagsStyle = this._style.copyWith(color: Config().highlightColor, fontSize: 16);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //category
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(widget.category.toUpperCase(), style: this._categorystyle),
          ),
          // title
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(widget.title.toUpperCase(), style: this._titleStyle, softWrap: true),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          //subtitle
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(widget.subtitle ?? '', style: this._subtitleStyle),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          //datetime
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(Utilities.postDateTime(DateTime.parse(widget.timeStamp)), style: this._dateStyle),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          //tags
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(Utilities.tagsString(widget.tags), style: this._tagsStyle),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
        ],
      ),
    );
  }
}

class FeatureImageBlock extends StatefulWidget {
  _FeatureImageBlockState createState() => _FeatureImageBlockState();
}

class _FeatureImageBlockState extends State<FeatureImageBlock> {
  static const String imageUrl = 'https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=579&q=100';
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover, alignment: Alignment.center),
        ));
  }
}

/// todo: here is the marked options  and proposed guidelines for a Section.
/// - the section left space and right space are the one to shrink, since that is the safe area.
/// - users will be will be forced to change postion placed in the safe area when the window size cannot fit the childern of the safe area widgets.
/// - change in the postion will follow a strict rule since [row] will be chnaged to a [column].
class BlogContentSection extends StatefulWidget {
  /// Background decoration for section.
  ///
  /// **Note: This acts as a backgrodund decoration for all the blocks laid in the section and can also be not shown if blocks are tightly packed and not opaque.**`
  final BoxDecoration? sectionDecoration;

  const BlogContentSection({Key? key, this.sectionDecoration}) : super(key: key);
  _BlogContentSectionState createState() => _BlogContentSectionState();
}

class _BlogContentSectionState extends State<BlogContentSection> {
  /// height of the section.
  final double sectionHeight = 1000.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.sectionHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //left space
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: this.sectionHeight,
            color: Colors.red,
          ),
          //center space
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            height: this.sectionHeight,
          ),
          // right space.
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: this.sectionHeight,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

/// Widget reads the metadata file and shows the latest posts that are published to the Blog.
///
/// A separate **`latestPost.meta.json`** file is maintained in .meta folder which contains the latest five posts published to the blog.
/// The widget will discard any posts that are more than two weeks old.
/// If all the posts are two weeks old then the widget will not be shown to the user.
class SidePostsBlock extends StatefulWidget {
  _SidePostsBlockState createState() => _SidePostsBlockState();
  /// Title for the [SidePostsBlock].
  final String title;
  SidePostsBlock({Key? key, required this.title,}) : super(key: key);
}

class _SidePostsBlockState extends State<SidePostsBlock> {
  // final List<Map<String,dynamic>>_latestPostMetaDataList = [{
  //   'id':''
  // }];

  // Encapusaltes the title from into a pre-themed widget.
  Widget titleWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
