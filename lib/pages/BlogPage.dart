import 'dart:async' show Timer;
import 'dart:ui' as ui show ImageFilter;

import 'package:flutter/material.dart';
import 'package:web/components/FeaturedPostTileComponents.dart';

///todo: remove this.
const List<FeaturedPost> _featuredPost = [
  FeaturedPost('Instagram will be Getting new Features for Monetization', ['test'], ['test1'],
      'https://iammrnerdsite.files.wordpress.com/2020/05/untitled-1.png', 'mr nerd'),
  FeaturedPost('New ‘Mysterious Jungle’ mode to come in PUBG Mobile on June 1,2020', ['test'], ['test1'],
      'https://iammrnerdsite.files.wordpress.com/2020/05/ey_visawoae5vlz.jpg', 'mr nerd'),
  FeaturedPost('DJI Mavic Air- Redefining portability.', ['test'], ['test1'], 'https://iammrnerdsite.files.wordpress.com/2018/01/final_feature.jpg', 'mr nerd'),
];

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
  void changeFeaturedPost(NavDirection direction) {
    late final double _offset;
    final double _currentOffset = (widget.screenSize.width - (_margin * 2)) * _currentIndex;
    final double _change = widget.screenSize.width - (_margin * 2);

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
        width: widget.screenSize.width - 32,
        height: _featuredTileHeight,
        margin: EdgeInsets.fromLTRB(_margin, 55.0, _margin, 20.0),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                            //child: _featuredPostImage(i)
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
                  scrollController: _featuredPostScrollController,
                  direction: NavDirection.forward,
                  scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
            ),
            Positioned(
              top: _featuredTileHeight / 2 - 55,
              left: 20.0,
              child: FeaturedPostTileNavButton(
                  scrollController: _featuredPostScrollController,
                  direction: NavDirection.backward,
                  scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
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
  static const double _margin = 16.0;
  static const double _rad = 12.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: widget.screenSize.width - (_margin * 2),
      margin: EdgeInsets.fromLTRB(_margin, _margin / 2, _margin, _margin / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(_rad),
      ),
    );
  }
}
