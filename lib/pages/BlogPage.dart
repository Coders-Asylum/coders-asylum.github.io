import 'dart:async' show Timer;
import 'dart:ui' as ui show ImageFilter;

import 'package:flutter/material.dart';

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
      body: LayoutBuilder(
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

  /// Blur Strength.
  static const double _blur = 12.0;

  /// margin of the featured tile;
  static const double _margin = 16.0;

  /// Scroll Controller to control the scrolling of featured posts.
  final ScrollController _featuredPostScrollController = ScrollController(initialScrollOffset: 0.0);

  /// Animation Controller to change the Featured Post.
  late final AnimationController _featuredPostAnimationController;

  /// Global Key for [_FeaturedTile]
  final GlobalKey _featuredPostTileKey = GlobalKey();

  /// The timer that rotates the featured post periodically
  late final Timer? _postTimer;

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

  /// Changes the Feature post to the next/previous post on button click.
  void changeFeaturedPost(NavDirection direction) {
    late final double _offset;
    final double _currentOffset = (widget.screenSize.width - (_margin * 2)) * _currentIndex;
    final double _change = widget.screenSize.width - (_margin * 2);

    //_featuredPostAnimationController.stop(canceled: false);
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
    Timer.periodic(Duration(milliseconds: 500), (t) async {
      if (_postTimer == null) {
        _postTimer = t;
        changeFeaturedPost(NavDirection.forward);
        await Future.delayed(Duration(milliseconds: 500));
      }
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
    return Container(
      key: _featuredPostTileKey,
      width: widget.screenSize.width - 32,
      height: _featuredTileHeight,
      margin: EdgeInsets.fromLTRB(_margin, 50.0, _margin, 20.0),
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
                        top: 200.0,
                        left: 150.0,
                        child: Container(
                          width: 425,
                          height: 275,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
                            border: Border.all(color: Colors.black.withOpacity(0.45), width: 1.0),
                            gradient: LinearGradient(
                                colors: [Colors.black54, Colors.black12], stops: [0.0, 1.0], begin: Alignment(-1.0, -1.0), end: Alignment(1.0, 1.0)),
                          ),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
                            child: Column(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Positioned(
            top: _featuredTileHeight / 2 - 50,
            right: 20.0,
            child: _FeaturedTileNavButton(
                scrollController: _featuredPostScrollController,
                direction: NavDirection.forward,
                scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
          ),
          Positioned(
            top: _featuredTileHeight / 2 - 50,
            left: 20.0,
            child: _FeaturedTileNavButton(
                scrollController: _featuredPostScrollController,
                direction: NavDirection.backward,
                scrollFunction: (NavDirection direction) => changeFeaturedPost(direction)),
          ),
        ],
      ),
    );
  }
}

/// To get the direction of the Nav Button on the [_FeaturedTile].
enum NavDirection {
  /// To navigate forward in the Featured List.
  forward,

  /// To navigate backward in the Featured List.
  backward,
}

typedef FeaturePostScrollFunction = void Function(NavDirection direction);

class _FeaturedTileNavButton extends StatefulWidget {
  final NavDirection direction;
  final ScrollController scrollController;
  final FeaturePostScrollFunction scrollFunction;

  const _FeaturedTileNavButton({Key? key, required this.scrollController, this.direction = NavDirection.forward, required this.scrollFunction})
      : super(key: key);

  _FeaturedTileNavButtonState createState() => _FeaturedTileNavButtonState();
}

class _FeaturedTileNavButtonState extends State<_FeaturedTileNavButton> {
  /// Radius of the button
  static const double _rad = 55.0;

  /// Padding inside the button.
  static const double _pad = 8.0;

  /// Boolean to check if Mouse pointer is over the button.
  bool _hover = false;

  /// Sets state of bool [_hover].
  ///
  /// SetState is called to change the state of the button.
  set _buttonState(bool hover) {
    setState(() {
      _hover = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _rad,
      width: _rad,
      padding: EdgeInsets.all(_pad),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(_hover ? 0.6 : 0.05),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: MouseRegion(
        onEnter: (e) => _buttonState = true,
        onExit: (e) => _buttonState = false,
        child: SizedBox.expand(
          child: RotatedBox(
            quarterTurns: widget.direction == NavDirection.forward ? 2 : 0,
            child: IconButton(
              alignment: Alignment.center,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                // size: _rad - (_pad * 2),
                color: Theme.of(context).accentColor.withOpacity(_hover ? 0.8 : 0.3),
              ),
              onPressed: () => widget.scrollFunction(widget.direction),
            ),
          ),
        ),
      ),
    );
  }
}

/// Featured Post are shown in the Featured Tile in the blog page of the website.
class FeaturedPost {
  final String title;
  final List<String>? topics;
  final List<String>? tags;
  final String imageUrl;
  final String? author;

  const FeaturedPost(this.title, this.topics, this.tags, this.imageUrl, this.author);

  @override
  String toString() {
    return '${this.title} written by ${this.title}.\nCategory: ${this.topics}.\nTags: ${this.tags}. Post image url: ${this.imageUrl}';
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
