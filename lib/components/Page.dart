// import 'package:flutter/material.dart';
//
// class PageTile extends StatefulWidget {
//   final Size safeArea;
//   final Color tileBackgroundColor;
//   final List<Widget> tileBackground;
//
//   PageTile({
//     this.safeArea = const Size(1440, 1240),
//     this.tileBackgroundColor = Colors.transparent,
//     this.tileBackground = const [],
//   });
//
//   final Widget child = tileChild();
//
//   @factory
//   Widget tileChild (){
//     throw UnimplementedError();
//   };
//   _PageTileState createState() => _PageTileState();
// }
//
// class _PageTileState extends State<PageTile> {
//   late final List<Widget> _widget;
//
//   void _generateStackChildren() {
//     _widget.add(SizedBox(height: widget.safeArea.height, width: MediaQuery.of(context).size.width, child: null));
//     if (widget.tileBackground.isNotEmpty) {
//       widget.tileBackground.forEach((element) {
//         _widget.add(element);
//       });
//       _widget.add(Container(height: widget.safeArea.height, width: widget.safeArea.width, child: widget.child));
//     }
//   }
//
//   @override
//   void initState() {
//     _generateStackChildren();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.safeArea.height,
//       width: MediaQuery.of(context).size.width,
//       color: widget.tileBackgroundColor,
//       child: Stack(
//         alignment: Alignment.center,
//         children: _widget,
//       ),
//     );
//   }
// }
