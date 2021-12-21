import 'dart:async' show Timer;
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:web/backend/pages/BlogPageService.dart' show BlogPageService;
import 'package:web/backend/Article.dart' show Post;
import 'package:web/components/blogPage/AllPostsTileComponents.dart';
import 'package:web/components/blogPage/FeaturedPostTileComponents.dart' show FeaturedPostTileNavButton, FeaturedPostTileNavDots, FeaturedPostInfo, FeaturedPost, NavDirection;
import 'package:web/components/blogPage/TopicsTileComponents.dart';

///todo: remove this demo lists.
const List<FeaturedPost> _featuredPost = [
  FeaturedPost('Instagram will be Getting new Features for Monetization', ['test'], ['test1'], '/test/res/test_images/red.jpg', 'mr nerd'),
  FeaturedPost('New ‘Mysterious Jungle’ mode to come in PUBG Mobile on June 1,2020', ['test'], ['test1'], '/test/res/test_images/green.jpg', 'mr nerd'),
  FeaturedPost('DJI Mavic Air- Redefining portability.', ['test'], ['test1'], '/test/res/test_images/blue.jpg', 'mr nerd'),
];

/// [_topics] only used to for testing and
/// emulating topics for topics tile.
const List<Topic> _topics = [
  Topic(
    name: 'Flutter',
    noOfPosts: 105,
    icon: AssetImage('lib/assets/res/flutterio-icon.png'),
    description:
        'Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase. The first version of Flutter was known as codename "Sky" and ran on the Android operating system.',
  ),
  Topic(
      name: 'Python',
      icon: AssetImage('lib/assets/res/python-icon.png'),
      noOfPosts: 65,
      description:
          'Python is an interpreted high-level general-purpose programming language. Python\'s design philosophy emphasizes code readability with its notable use of significant indentation.'),
  Topic(
      name: 'GoLang',
      icon: AssetImage('lib/assets/res/golang-icon.png'),
      noOfPosts: 30,
      description:
          'Go is a statically typed, compiled programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson. Go is syntactically similar to C, but with memory safety, garbage collection, structural typing, and CSP-style concurrency.'),
  Topic(
      name: 'C++',
      icon: AssetImage('lib/assets/res/cpp-icon.png'),
      noOfPosts: 55,
      description:
          'Go is a statically typed, compiled programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson. Go is syntactically similar to C, but with memory safety, garbage collection, structural typing, and CSP-style concurrency.'),
  Topic(name: 'More Topics', text: '+1', noOfPosts: 55, description: 'More Interesting topic, view them all'),
];

/// This page shows
class BlogPage extends StatefulWidget {
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    /// The current width of the user screen.
    final _screenWidth = MediaQuery.of(context).size.width;

    /// The current height of the user screen.
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Semantics(
        label: 'blogPostsPage',
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(),
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FeaturedTile(screenSize: Size(_screenWidth, _screenHeight)),
                        TopicsTile(screenSize: Size(_screenWidth, _screenHeight)),
                        Container(width: MediaQuery.of(context).size.width, height: 30.0, child: DividerLine(width: MediaQuery.of(context).size.width * 0.8)),
                        PostsTile(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Tile that shows the featured post for a week.
/// The post with meta data ```featured:true``` shows up in descending order of timeOfPost.
///
/// This also automatically  scrolls horizontally through the featured post periodically with [animateFeaturedPost] function.
/// [FeaturedPostTileNavButton] Helps in manual change of the featured posts by the user.
class FeaturedTile extends StatefulWidget {
  final Size screenSize;

  const FeaturedTile({Key? key, required this.screenSize}) : super(key: key);

  _FeaturedTileState createState() => _FeaturedTileState();
}

class _FeaturedTileState extends State<FeaturedTile> with SingleTickerProviderStateMixin {
  /// Height of the Featured Tile.
  static const double _featuredTileHeight = 500.0;

  /// Corner Radius of the Featured Tile.
  static const double _featuredTileCornerRadius = 12.0;

  /// margin of the featured tile;
  static const double _margin = 16.0;

  /// Scroll Controller to control the scrolling of featured posts.
  final ScrollController _featuredPostScrollController = ScrollController(initialScrollOffset: 0.0);

  /// Animation Controller to change the Featured Post.
  late final AnimationController _featuredPostAnimationController;

  int _currentIndex = 0;

  // /// Returns the widget that encloses the featured post image.
  // ///
  // /// If Normal [Image.network(src)] method raises error.
  // /// Then [ImageElement] is Inserted in to the document.
  // /// todo:(maverick099) get CORS for github since image would be hosted there.
  // Widget _featuredPostImage(int i) {
  //   late Widget _widget;
  //   late final ImageElement _imageElement = ImageElement(src: _featuredPost[i].imageUrl);
  //
  //   ui.platformViewRegistry.registerViewFactory('featurePostImage', (int viewId) {
  //     return _imageElement;
  //   });

  // try {

  // } on Exception {
  //
  //}
  //_widget = Image.network(_featuredPost[i].imageUrl);
  // _widget = HtmlElementView(
  //   key: _featuredPostTileKey,
  //   viewType: 'featurePostImage',
  // );

  //return _widget;
  //}

  /// Changes the Feature post to the next/previous post on Button tap.
  /// [direction] specified the horizontal scroll direction of the post.
  ///
  /// Periodically calling this will automatically change the post in the FeaturedPostTile.
  void changeFeaturedPost(NavDirection direction) {
    late final double _offset;
    final double _currentOffset = (widget.screenSize.width) * _currentIndex;
    final double _change = widget.screenSize.width;

    if (direction == NavDirection.forward) {
      if (_currentIndex == _featuredPost.length - 1) {
        _offset = 0.0;
        _currentIndex = 0;
      } else {
        _offset = _currentOffset + _change;
        _currentIndex++;
      }
    } else {
      if (_currentIndex == 0) {
        _offset = (_featuredPost.length - 1) * _change;
        _currentIndex = _featuredPost.length - 1;
      } else {
        _offset = _currentOffset - _change;
        _currentIndex--;
      }
    }

    _featuredPostScrollController.animateTo(_offset, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() {});
  }

  ///
  void animateFeaturedPost() async {
    Timer.periodic(Duration(seconds: 5, milliseconds: 500), (t) async {
      changeFeaturedPost(NavDirection.forward);
    });
  }

  @override
  void initState() {
    animateFeaturedPost();
    super.initState();
  }

  void dispose() {
    _featuredPostAnimationController.dispose();
    _featuredPostScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'featuredPost',
      child: Container(
        width: widget.screenSize.width,
        height: _featuredTileHeight,
        margin: EdgeInsets.fromLTRB(_margin, 55.0, _margin, 20.0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
          gradient: LinearGradient(
            begin: Alignment(-1.0, -1.0),
            end: Alignment(1.0, 1.0),
            colors: [Color(0xffCD5D7D), Color(0xffEA9ABB), Color(0xffA6B1E1), Color(0xff424874)],
            stops: [0.0, 0.35, 0.65, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
                controller: _featuredPostScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _featuredPost.length,
                padding: EdgeInsets.all(0.0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    width: widget.screenSize.width,
                    height: _featuredTileHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(_featuredPost[i].imageUrl), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 60.0,
                          left: 100.0,
                          child: FeaturedPostInfo(featuredPost: _featuredPost[i]),
                        ),
                      ],
                    ),
                  );
                }),
            Positioned(
              top: _featuredTileHeight / 2 - 50,
              right: 20.0,
              child: FeaturedPostTileNavButton(
                  scrollController: _featuredPostScrollController, direction: NavDirection.forward, scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
            ),
            Positioned(
              top: _featuredTileHeight / 2 - 55,
              left: 20.0,
              child: FeaturedPostTileNavButton(
                  scrollController: _featuredPostScrollController, direction: NavDirection.backward, scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
            ),
            Positioned(
              left: widget.screenSize.width / 2 - (_featuredPost.length * 15),
              bottom: 10.0,
              child: FeaturedPostTileNavDots(currentIndex: _currentIndex, totalPosts: _featuredPost.length),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicsTile extends StatefulWidget {
  final Size screenSize;

  const TopicsTile({Key? key, required this.screenSize}) : super(key: key);

  _TopicsTileState createState() => _TopicsTileState();
}

class _TopicsTileState extends State<TopicsTile> {
  /// Margin for the topic tile and its widgets
  static const double _margin = 16.0;

  /// Corner radius of the topics tile.
  static const double _rad = 12.0;

  /// Height of each [TopicContainer]
  static const double _topicContainerHeight = 251.0;

  /// Width of each [TopicContainer]
  static const double _topicContainerWidth = 190.0;

  /// Size increase percentage of each [TopicContainer]
  static const double _topicContainerGrowth = 0.5;

  /// Returns the list of topics enclosed inside the [TopicContainer] widget.
  /// todo: arrange the topic list according to the no of posts.
  /// todo: add the number of not shown topics at the end of the list.
  List<Widget> topics(BuildContext context, List<Topic> topics) {
    late List<Widget> _widgets = [];
    topics.forEach((t) {
      _widgets.add(TopicContainer(
        t,
        height: _topicContainerHeight,
        width: _topicContainerWidth,
        screenSize: widget.screenSize,
        growth: _topicContainerGrowth,
      ));
    });
    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _topicContainerHeight + 100 + (_topicContainerHeight * _topicContainerGrowth),
      width: widget.screenSize.width - (_margin * 2),
      margin: EdgeInsets.fromLTRB(_margin, _margin / 2, _margin, _margin / 2),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor.withOpacity(0.1), borderRadius: BorderRadius.circular(_rad)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: widget.screenSize.width,
            margin: EdgeInsets.all(_margin / 2),
            child: Text('VIEW BY TOPICS', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24.0, fontFamily: 'Gobold')),
          ),
          SizedBox(
            width: widget.screenSize.width,
            height: _topicContainerHeight + (_topicContainerHeight * _topicContainerGrowth),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: topics(context, _topics),
            ),
          ),
        ],
      ),
    );
  }
}

/// Creates a divider line to show change of contents context in the UI.
///
/// eg Code:
/// ``` dart
///  // parent widget.
///  Container(
///     height: 100.0,
///     width: 600.0,
///     child: DividerLine(
///         width: 600.0*0.8, // 80% of the width of the parent widget.
///     ),
///  );
/// ```
///
class DividerLine extends StatelessWidget {
  /// Width of the divider line.
  ///
  /// should be 80% of the parent width for better and standard visual practice.
  ///
  final double width;

  /// Color of the Divider line.
  final Color color;

  /// This is the stroke width of the line, is defaulted to 8.
  final double lineWidth;

  /// Defines the decoration of the divider line, is initialized in the constructor.
  late final Decoration _decoration;

  //constructor
  DividerLine({Key? key, required this.width, this.color = Colors.white, this.lineWidth = 8.0}) : super(key: key) {
    _decoration = BoxDecoration(
      color: this.color,
      borderRadius: BorderRadius.all(Radius.circular(this.lineWidth / 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'dividerLine',
      child: Container(
        height: this.lineWidth + 4,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          width: this.width,
          height: this.lineWidth,
          decoration: _decoration,
        ),
      ),
    );
  }
}

/// Tile that shows all the recent posts in a list view,
/// this is showed in chronological order of the post date.
///
/// There are two type of the post are displayed in list.
///  - [NormalPostTile] : This shows the post featured image, title, subtitle, author name, post date and number of likes.
///  - [ImagePostTile] : This type of the post in the list is shown bigger from the normal post tile and the all the post details
///  but the featured image of the post is enlarged showing more attention to the post.
///
///   The post details and the type of the post is defined in the post data json file.
///  This is maintained as meta data inside the metaData folder.
///
class PostsTile extends StatefulWidget {
  _PostsTileState createState() => _PostsTileState();
}

class _PostsTileState extends State<PostsTile> {
  /// only for testing purpose
  /// todo: remove this in production build.
  static const String postMetaData = testJSONString;

  /// BlogPageService object.
  final BlogPageService service = BlogPageService();

  /// stores all the post meta data as list of [Post] object.
  late final List<Post> posts;

  /// returns the calculated height for the tile.
  /// initially initialised with an offset to overcome any renderBox overflow errors.
  late double height = 16;

  /// Generates list of widget, with respect to the type of post on metadata.
  List<Widget> allPostsList() {
    late List<Widget> _l = [];
    posts.forEach((post) {
      if (post.type == 'normal') {
        _l.add(NormalPostTile(
          title: post.title,
          subtitle: post.subtitle,
          authorName: service.generateAuthorName(post.authorId),
          postDateTime: post.timeStamp,
          postLikes: post.likes,
          imageUrl: post.featuredImage,
        ));
      } else if (post.type == 'image_post') {
        _l.add(ImagePostTile(
          title: post.title,
          subtitle: post.subtitle,
          authorName: service.generateAuthorName(post.authorId),
          postDateTime: post.timeStamp,
          postLikes: post.likes,
          imageUrl: post.featuredImage,
        ));
      }
    });
    return _l;
  }

  ///
  void setHeight() {
    posts.forEach((post) {
      if (post.type == 'normal') {
        height += (normalPostTileDimension.height + normalPostTileDimension.margin.bottom + normalPostTileDimension.margin.top);
      } else if (post.type == 'image_post') {
        height += (imagePostTileDimension.height + imagePostTileDimension.margin.bottom + imagePostTileDimension.margin.top);
      }
    });
  }

  @override
  void initState() {
    posts = service.generatePostList(json.decode(postMetaData));
    setHeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // outer container
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // posts list
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: allPostsList(),
          ),
        ],
      ),
    );
  }
}

const String testJSONString = '''
[{
		"id": 1,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "New Google Feature Highlights the Search Results on External Websites.",
		"subtitle": "Now Google highlights your search results in yellow to improve your search experience inside external websites. This functionality works with Google’s Featured Snippets, these snippets are the containers (boxes) that show results for your search so you do not have to visit the website.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [1],
		"category": ["news", "seo"],
		"tags": ["google", "news"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:07:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},
	{
		"id": 2,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "End to End Encryption Won’t Be Available to Free Users-says Zoom.",
		"subtitle": "This comes after the Eric Yuan Zoom CEO’s meeting with the investors on Tuesday. Zoom says that end to end encryption won’t be provided to the free user’s which means law enforcement agencies can look into your video calls.",
		"file": "",
		"featuredImage": "",
		"featured": false,
		"authorId": [1],
		"category": ["news"],
		"tags": ["zoom", "security"],
		"likes": 34,
		"comments": [{
				"id": "1",
				"name": "",
				"timeStamp": "2021-12-08 16:50:29.551Z",
				"comment": "",
				"flags": ["", ""],
				"reply": []
			},
			{
				"id": "2",
				"name": "tester",
				"timeStamp": "2021-12-08 16:07:29.551Z",
				"comment": "test comment",
				"flags": ["pinned", "author"],
				"reply": [{
					"id": "2:1",
					"name": "tester",
					"timeStamp": "2021-12-08 16:50:29.551Z",
					"comment": "test comment",
					"flags": ["pinned", "author"],
					"reply": []
				}, {
					"id": "2:2",
					"name": "tester",
					"timeStamp": "2021-12-08 17:45:29.551Z",
					"comment": "test comment",
					"flags": ["pinned", "author"],
					"reply": [{
						"id": "2:2:1",
						"name": "tester",
						"timeStamp": "2021-12-08 17:50:30.551Z",
						"comment": "test comment",
						"flags": ["pinned", "author"],
						"reply": []
					}]
				}]
			}

		]
	},

	{
		"id": 3,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "image_post",
		"title": "Instagram will be Getting new Features for Monetization.",
		"subtitle": "Instagram says on a blog post that it will be helping creators on its platform who create their original content by Helping them to monetize their content. In the recent COVID-19 Pandemic Instagram has seen a surge in increase of users in its app and the live broadcast has seen a 70% increase in views. ",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [1],
		"category": ["news", "social_media"],
		"tags": ["Instagram", "Social Media"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},

	{
		"id": 4,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "New ‘Mysterious Jungle’ mode to come in PUBG Mobile on June 1,2020",
		"subtitle": "The popular Battle Royale game took their twitter handle to tease a new mode. It is called the Mysterious Jungle mode and will be available to be played on June 1, 2020.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [1],
		"category": ["news"],
		"tags": ["pubg", "games"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},

	{
		"id": 5,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "Zipline’s Drone has Started delivering medical Supplies in North Carolina.",
		"subtitle": "According to Zipline, it is the first drone logistics company approved by the US for long Range deliveries of medical supplies to the hospitals. The Zipline drone ca cover a are of over 16o km.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [1],
		"category": ["news"],
		"tags": ["zipline", "medical"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	}]''';
