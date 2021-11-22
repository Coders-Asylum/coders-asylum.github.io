import 'package:flutter/material.dart';
import 'package:web/components/NameIconWidget.dart';

class Post {}

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

  /// Creates a vertical line that acts as an divider between widgets.
  Widget verticalDivider() {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
      child: VerticalDivider(width: 18.0, color: Theme.of(context).highlightColor, endIndent: 1.0, indent: 1.0, thickness: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    // background container.
    return Semantics(
      label: 'normalPost',
      child: Container(
        height: 216,
        width: 971,
        decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.all(8.0),
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
                Container(
                  height: 24.0,
                  width: 579,
                  margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Author name.
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: 24.0,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'by ', style: TextStyle(color: Theme.of(context).highlightColor)),
                                  TextSpan(text: widget.authorName, style: TextStyle(color: ColorScheme.fromSwatch().secondary))
                                ], style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))))),
                      ),
                      verticalDivider(),
                      // Time placeholder.
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                              child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            child: Text(widget.postDateTime.toString(), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron', color: Theme.of(context).highlightColor)),
                          ))),
                      verticalDivider(),
                      //Like Icon
                      SizedBox(height: 24.0, width: 24.0, child: Icon(Icons.thumb_up, size: 18.0, color: Colors.white)),
                      // Like count
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 24.0,
                              child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.contain,
                            child: Text(widget.postLikes.toString(), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron', color: Theme.of(context).highlightColor)),
                          )))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

