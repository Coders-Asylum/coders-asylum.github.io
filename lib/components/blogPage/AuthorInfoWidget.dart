import 'package:flutter/material.dart';

/// Is a miniature sized post details with author name, the time of post and total post likes.
///
class AuthorPostInfoMiniatureWidget extends StatefulWidget {
  /// Height of the widget.
  final double height;

  /// Width of the widget.
  final double width;

  /// Name of the Author of the post.
  final String authorName;

  /// Post date and time of publish in UTC.
  final DateTime? postDateTime;

  /// Post number of likes.
  final int? postLikes;

  const AuthorPostInfoMiniatureWidget({Key? key, required this.height, required this.width, this.authorName = 'Anonymous', this.postDateTime, this.postLikes}) : super(key: key);

  _AuthorPostInfoMiniatureWidgetState createState() => _AuthorPostInfoMiniatureWidgetState();
}

class _AuthorPostInfoMiniatureWidgetState extends State<AuthorPostInfoMiniatureWidget> {
  /// Creates a vertical line that acts as an divider between widgets.
  Widget verticalDivider() {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
      child: VerticalDivider(width: 18.0, color: Theme.of(context).highlightColor, endIndent: 1.0, indent: 1.0, thickness: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height, //24.0,
      width: widget.width, //579,
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
    );
  }
}
