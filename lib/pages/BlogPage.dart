import 'dart:async' show Timer;

import 'package:flutter/material.dart';
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
  static const double _topicContainerHeight = 250.0;

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
