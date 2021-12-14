import 'dart:ui' as ui show ImageFilter;
import 'package:flutter/material.dart';
import 'package:web/backend/WidgetDimension.dart';
import 'package:web/components/NameIconWidget.dart' show NameIcon;
import 'package:web/components/blogPage/AuthorInfoWidget.dart' show AuthorPostInfoMiniatureWidget;

/// Dimension for [NormalPostTile].
const WidgetDimension normalPostTileDimension = const WidgetDimension(width: 971.0, height: 216, margin: const EdgeInsets.all(8.0), padding: const EdgeInsets.all(4.0));

/// Dimension for [ImagePostTile].
const WidgetDimension imagePostTileDimension = const WidgetDimension(width: 971.0, height: 702, margin: const EdgeInsets.all(8.0), padding: const EdgeInsets.all(8.0));

/// NormalPostTile is placeholder with normal and simple post details.
/// Such as the post, title, subtitle, post image, author name and user likes count.
///
class NormalPostTile extends StatefulWidget {
  /// Title of the post.
  final String title;

  /// Relative path of the post image.
  final String? imageUrl;

  /// Sub title of the post.
  final String? subtitle;

  /// Name of the Author of the post.
  final String authorName;

  /// Post date and time of publish in UTC.
  final DateTime? postDateTime;

  /// Post number of likes.
  final int? postLikes;

  const NormalPostTile({Key? key, required this.title, this.imageUrl, this.subtitle, this.authorName = 'Anonymous', this.postDateTime, this.postLikes}) : super(key: key);

  _NormalPostTileState createState() => _NormalPostTileState();
}

class _NormalPostTileState extends State<NormalPostTile> {
  /// Background color for normal tile.
  static const Color _backgroundColor = Color(0xff2C2C2C);

  @override
  Widget build(BuildContext context) {
    // background container.
    return Semantics(
      label: 'normalPost',
      child: Container(
        height: normalPostTileDimension.height,
        width: normalPostTileDimension.width,
        decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(5.0)),
        padding: normalPostTileDimension.padding,
        margin: normalPostTileDimension.margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image placeholder container.
            widget.imageUrl == null
                ? NameIcon(name: widget.title, backgroundColor: Color(0xffC4C4C4), textColor: Colors.indigo)
                : Container(
                    height: 177,
                    width: 309,
                    decoration: BoxDecoration(color: Color(0xffC4C4C4), image: DecorationImage(image: NetworkImage(widget.imageUrl!), fit: BoxFit.cover)),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title placeholder.
                Container(
                  height: 92,
                  width: 579,
                  margin: EdgeInsets.all(8.0),
                  child: FittedBox(
                    alignment: Alignment.topLeft,
                    fit: BoxFit.contain,
                    child: Text(widget.title, maxLines: 4, softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Gobold', fontSize: 36, color: Theme.of(context).primaryColor)),
                  ),
                ),
                // subtitle placeholder
                Container(
                  height: 46,
                  width: 579,
                  margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: Text(widget.subtitle!,
                      maxLines: 3, softWrap: true, style: TextStyle(fontFamily: 'Source Code', fontSize: 18.0, overflow: TextOverflow.ellipsis, color: Theme.of(context).highlightColor)),
                ),
                //Author name placeholder and post details.
                AuthorPostInfoMiniatureWidget(
                  height: 24,
                  width: 579,
                  authorName: widget.authorName,
                  postDateTime: widget.postDateTime,
                  postLikes: widget.postLikes,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// An Image post displays the feature image enlarged.
/// Which shows more attraction to the post.
///
///
/// And the subtitle is floating in a box over an image giving some visual enhancement.
class ImagePostTile extends StatefulWidget {
  /// Title of the post.
  final String title;

  /// Relative path of the post image.
  final String? imageUrl;

  /// Sub title of the post.
  final String? subtitle;

  /// Name of the Author of the post.
  final String authorName;

  /// Post date and time of publish in UTC.
  final DateTime? postDateTime;

  /// Post number of likes.
  final int? postLikes;

  _ImagePostTileState createState() => _ImagePostTileState();

  const ImagePostTile({Key? key, required this.title, this.imageUrl, this.subtitle, this.authorName = 'Anonymous', this.postDateTime, this.postLikes}) : super(key: key);
}

class _ImagePostTileState extends State<ImagePostTile> {
  /// Blur strength for the subtitle container.
  static const double _blur = 8.0;

  /// Corner radius of the boxes.
  static const double _rad = 8.0;

  /// This takes in the [text] and returns a widget that shows the text has a text with stroke.
  ///
  /// This works in the way where it lays a text with stroke using the foreground parameter
  /// over normal text using the [stack] widget.
  Widget strokedText(String text, {Color color = Colors.white, double strokeWidth = 0.5, Color strokeColor = Colors.black, double fontSize = 22.0, String fontFace = 'Orbitron'}) {
    /// key to differentiate the un-stroked Text Widget.
    const Key _unStroked = Key('unStroked_text');

    /// key to differentiate the stroked Text Widget.
    const Key _stroked = Key('stroked_text');

    /// This specifies the common textStyle properties in one parameter.
    TextStyle textStyle = TextStyle(fontSize: fontSize, fontFamily: fontFace);

    return Stack(children: [
      Text(text,
          key: _stroked,
          style: textStyle.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..color = strokeColor),
          softWrap: true),
      Text(text, key: _unStroked, style: textStyle.copyWith(color: color), softWrap: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'imagePost',
      child: Container(
        height: imagePostTileDimension.height,
        width: imagePostTileDimension.width,
        padding: imagePostTileDimension.padding,
        margin: imagePostTileDimension.margin,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(_rad)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // title place holder.
            SizedBox(
              height: 101,
              width: 882,
              child: Text(widget.title, softWrap: true, style: TextStyle(fontSize: 42, color: Color(0xff1366C8))),
            ),

            AuthorPostInfoMiniatureWidget(height: 24.0, width: 524, authorName: widget.authorName, postDateTime: widget.postDateTime, postLikes: widget.postLikes),
            // Image and subtitle placeholder.
            Container(
              height: 507.37,
              width: MediaQuery.of(context).size.width, //920,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: [
                  Container(
                    height: 507.37,
                    width: 920,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      image: DecorationImage(image: NetworkImage('/lib/assets/iron.jpg'), fit: BoxFit.fill, alignment: Alignment.center),
                      borderRadius: BorderRadius.circular(_rad),
                    ),
                  ),
                  // subtitle

                  Positioned(
                      bottom: imagePostTileDimension.height - (imagePostTileDimension.height - 16.0),
                      left: imagePostTileDimension.width - (imagePostTileDimension.width - 16.0),
                      child: Visibility(
                        visible: widget.subtitle != null,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaY: _blur, sigmaX: _blur),
                            child: Container(
                              height: 162.0,
                              width: 612,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Color(0xff000000).withOpacity(0.64), Color(0xff484848).withOpacity(0.64)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.30, 1.0]),
                                borderRadius: BorderRadius.circular(_rad),
                              ),
                              child: strokedText(widget.subtitle!),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
Widget strokeTextTest(String text, {Color color = Colors.white, double strokeWidth = 0.5, Color strokeColor = Colors.black, double fontSize = 22.0, String fontFace = 'Orbitron'}) {
  return _ImagePostTileState().strokedText(text, color: color, strokeWidth: strokeWidth, strokeColor: strokeColor, fontSize: fontSize, fontFace: fontFace);
}
