import 'dart:ui' as ui show ImageFilter;

import 'package:flutter/material.dart';
import 'package:web/components/NameIconWidget.dart' show NameIcon;

/// Featured Post are shown in the Featured Post Tile in the blog page of the website.
///
/// At a time only a maximum of 6 latest post tagged as featured post is shown.
/// The featured post list changes on a submission of new post and the oldest post is removed from the list,
/// if the number of posts exceeds from 6.
class FeaturedPost {
  final String title;
  final List<String>? topics;
  final List<String>? tags;
  final String imageUrl;
  final String? author;

  const FeaturedPost(this.title, this.topics, this.tags, this.imageUrl, this.author);

  @override
  String toString() {
    return '${this.title} written by ${this.title}.\nCategory: ${this.topics}.\nTags: ${this.tags}.\nPost image url: ${this.imageUrl}';
  }
}

/// List of Dots that help the user see the number of Featured Posts
/// and help them visualise the position of the current post in the sequence.

class FeaturedPostTileNavDots extends StatefulWidget {
  /// The current index of the featured Post tile.
  final int currentIndex;

  final int totalPosts;

  const FeaturedPostTileNavDots({required this.currentIndex, required this.totalPosts});

  _FeaturedPostTileNavDotsState createState() => _FeaturedPostTileNavDotsState();
}

class _FeaturedPostTileNavDotsState extends State<FeaturedPostTileNavDots> {
  /// diameter of the dots
  static const double _dia = 10.0;

  /// The change in radius when the dot is active.
  static const double _change = 5.0;

  /// Margin between each dots.
  static const double _margin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'nav dots',
      child: Container(
        height: _dia + _change,
        width: widget.totalPosts * (_dia + _change + _margin * 2),
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: ScrollController(),
          itemCount: widget.totalPosts,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int i) => Container(
            height: i == widget.currentIndex ? _dia + _change : _dia,
            width: i == widget.currentIndex ? _dia + _change : _dia,
            margin: i == widget.currentIndex ? EdgeInsets.fromLTRB(_margin, 0.0, _margin, 0.0) : EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            decoration: BoxDecoration(
              color: i == widget.currentIndex ? Colors.black.withOpacity(0.8) : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: i == widget.currentIndex ? Colors.transparent : Colors.black, width: 1.5),
            ),
            child: Semantics(label: 'dot $i'),
          ),
        ),
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

/// Functions that changes the Featured Post Depending on the [direction] parameter.
typedef FeaturePostScrollFunction = void Function(NavDirection direction);

/// Navigational Buttons to manually change/ Scroll through the Featured Posts in the Featured Post Tile Section.
class FeaturedPostTileNavButton extends StatefulWidget {
  final NavDirection direction;
  final ScrollController scrollController;
  final FeaturePostScrollFunction scrollFunction;

  const FeaturedPostTileNavButton({Key? key, required this.scrollController, this.direction = NavDirection.forward, required this.scrollFunction}) : super(key: key);

  _FeaturedPostTileNavButtonState createState() => _FeaturedPostTileNavButtonState();
}

class _FeaturedPostTileNavButtonState extends State<FeaturedPostTileNavButton> {
  /// Diameter of the button
  static const double _dia = 55.0;

  /// Padding inside the button.
  static const double _pad = 8.0;

  /// Boolean to check if Mouse pointer is over the button.
  bool _hover = false;

  /// Sets state of bool [_hover].
  ///
  /// SetState is called to change the state of the button.
  set _buttonState(bool hover) => setState(() => _hover = hover);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _dia,
      width: _dia,
      padding: EdgeInsets.all(_pad),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(_hover ? 0.6 : 0.05),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Semantics(
        label: 'Navigation Button',
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
      ),
    );
  }
}

/// This show all the relevant information on the featured post.
///
/// This includes the post tile, the author name, the tags, topics included.
class FeaturedPostInfo extends StatefulWidget {
  final FeaturedPost featuredPost;

  FeaturedPostInfo({required this.featuredPost});

  FeaturedPostInfoState createState() => FeaturedPostInfoState();
}

@visibleForTesting
class FeaturedPostInfoState extends State<FeaturedPostInfo> {
  /// Blur Strength.
  static const double _blur = 50.0;

  /// corner radius
  static const double _featuredTileCornerRadius = 12.0;

  /// height of the info container.
  final double _height = 275.0;

  /// width of the info container.
  final double _width = 425.0;

  /// The author name from the featured post.
  String get author => widget.featuredPost.author == null ? 'Anonymus Hacker' : widget.featuredPost.author!;

  /// The title of the featured post.
  String get title => widget.featuredPost.title;

  /// The tags in the featured post
  String get tags => list2String(widget.featuredPost.tags, tags: true);

  /// The topics of the featured post.
  String get topics => list2String(widget.featuredPost.topics);

  /// Converts a list of string to a single string.
  ///
  /// if [tags] is true then a '#' is added in start of each string in the given list.
  @visibleForTesting
  String list2String(List<String>? list, {bool tags = false}) {
    late String _s = '';
    if (list != null && list.isNotEmpty) {
      list.forEach((s) {
        _s += tags ? '#$s ' : '$s ';
      });
    }
    return _s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      constraints: BoxConstraints(maxHeight: _height),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_featuredTileCornerRadius),
        border: Border.all(color: Colors.black.withOpacity(0.45), width: 1.0),
        gradient: LinearGradient(colors: [Colors.black26, Colors.black.withOpacity(0.1)], stops: [0.0, 1.0], begin: Alignment(-1.0, -1.0), end: Alignment(1.0, 1.0)),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // topics placeholder.
            Container(
              width: _width,
              height: _height * 0.08,
              margin: EdgeInsets.only(bottom: 3.0),
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
                child: Text(
                  topics,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: 'Source Code', color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            // divider.
            Container(
                height: _height * 0.008,
                width: _width - (_width * 0.30),
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(3.0))),
            // title place holder.
            Container(
              width: _width,
              constraints: BoxConstraints(maxHeight: _height * 0.25),
              margin: EdgeInsets.all(5.0),
              child: Text(
                title.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                softWrap: true,
                textAlign: TextAlign.left,
                semanticsLabel: 'featuredPostTitle',
                style: TextStyle(wordSpacing: 3.0, fontSize: 24.0, fontFamily: 'Gobold', color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            // Author container
            Container(
              height: _height * 0.15,
              width: _width,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: _height * 0.15,
                    width: _height * 0.15,
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: NameIcon(name: author, backgroundColor: Theme.of(context).accentColor, textColor: Colors.white),
                  ),
                  Container(
                      height: _height * 0.15,
                      width: _width - _height * 0.15 - 20,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(fit: BoxFit.contain, child: Text(author, style: TextStyle(fontFamily: 'Source Sans', color: Theme.of(context).primaryColor)))),
                ],
              ),
            ),

            /// tags place holder
            Container(
              height: _height * 0.05,
              width: _width,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
              child: FittedBox(fit: BoxFit.contain, child: Text(tags, textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Sorce Code', color: Theme.of(context).highlightColor))),
            ),
          ],
        ),
      ),
    );
  }
}
