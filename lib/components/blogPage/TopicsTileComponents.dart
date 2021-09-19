import 'package:flutter/material.dart';

/// Topics are the coding languages that are being explained in blog posts
///
/// Most viewed and written topics are shown below the featured post section.
class Topic {
  /// The name of the topic.
  final String name;

  /// The description topic the topic
  final String description;

  /// Official logo/mascot of the coding language.
  final ImageProvider? icon;

  /// add text instead of [icon].
  final String? text;

  /// The number of posts written under this topic.
  ///
  /// This will be read from the metadata of the website.
  final int noOfPosts;

  const Topic({
    required this.name,
    this.icon,
    this.text,
    required this.noOfPosts,
    this.description = 'start learning',
  })  : assert(noOfPosts > 0, 'Number of posts should be at least 1'),
        assert(icon == null || text == null,
            'Only one of the two can be specified');

  @override
  String toString() {
    return 'Topic{name:${this.name}, icon:${this.icon.toString()}, number of posts: ${this.noOfPosts}}';
  }

  @override
  noSuchMethod(Invocation invocation) {
    return '$invocation is not defined in ${this.runtimeType}';
  }
}

/// The container that shows the topic.
///
/// This enlarges on mouse hover.
class TopicContainer extends StatefulWidget {
  /// The [Topic] of the current container.
  final Topic topic;

  /// The screen size of the current context
  final Size screenSize;

  /// The Height of the Container
  final double height;

  /// The width of the container
  final double width;

  /// The percentage of growth added to the height or the width of the container.
  ///
  /// This should be in between 0.1 and 1.0.
  final double growth;

  const TopicContainer(this.topic,
      {this.screenSize = Size.zero,
      required this.height,
      required this.width,
      this.growth = 0.5})
      : assert(growth >= 0.1 && growth <= 1.0,
            'growth is percentage growth and should be between 0.1 and 1.0');

  _TopicContainerState createState() => _TopicContainerState();
}

class _TopicContainerState extends State<TopicContainer>
    with SingleTickerProviderStateMixin {
  /// Animation duration in milliseconds.
  static const int _milliseconds = 200;

  /// Animation curve of the container.
  static const Curve _curve = Curves.easeInOut;

  /// The height of the container depending on the state.
  late double _height = widget.height;

  /// The width of the container depending on the state.
  late double _width = widget.width;

  /// Bool for visibility of the description
  late bool _visible = false;

  /// Changes the values of [_width] and [_height] of the container depending on the [grow] parameter.
  void changeSize(bool grow) {
    setState(() {
      _visible = grow;
      if (grow) {
        _width = widget.width + widget.width * widget.growth;
        _height = widget.height + widget.height * widget.growth;
      } else {
        _width = widget.width;
        _height = widget.height;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => changeSize(true),
      onExit: (e) => changeSize(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: _milliseconds),
        height: _height,
        width: _width,
        curve: _curve,
        alignment: Alignment.center,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              padding: EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
              child: widget.topic.text == null
                  ? Image(image: widget.topic.icon!, fit: BoxFit.contain)
                  : FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      child: Text(widget.topic.text!.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Gobold',
                              color: Theme.of(context).primaryColor)),
                    ),
            ),
            Visibility(
              visible: _visible,
              maintainAnimation: true,
              maintainState: true,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: AnimatedContainer(
                  duration: Duration(
                      milliseconds:
                          _visible ? _milliseconds * 3 : _milliseconds - 50),
                  curve: _curve,
                  height: _visible ? _height * 0.25 : 0.0,
                  width: _width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: EdgeInsets.all(_visible ? 8.0 : 0.0),
                  margin: EdgeInsets.all(_visible ? 8.0 : 0.0),
                  child: RichText(
                    overflow: TextOverflow.fade,
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      mouseCursor: SystemMouseCursors.text,
                      children: <TextSpan>[
                        TextSpan(
                            text: "${widget.topic.name}\n",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Gobold',
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: widget.topic.description,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Source Code',
                                color: Theme.of(context).highlightColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
