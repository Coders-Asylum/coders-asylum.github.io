import 'package:flutter/material.dart';

/// todo(@maverick099): Create a class for SideBarItems/Tabs.
/// todo(@maverick099): The SideBarItems/Tabs should be able to navigate to page or launch Url.
/// todo(@maverick099): remember to take in consideration of the width of different widgets while using the sidebar in the stack

/// Positions of the SideBar.
enum Position { left, right }

/// Creates the SideBar that goes either on the Left or Right of the Screen.
/// Text inside is placed parallel to the vertical axis of the screen.
class SideBar extends StatefulWidget {
  /// Alignment of the children inside the [SideBar].
  final Alignment alignment;

  /// The height of the SideBar.
  ///
  /// - Remember the [SideBar] is rotated and placed in the Page.
  /// - So the width of a non-transformed Container becomes [verticalHeight].
  final double verticalHeight;

  /// The width of the SideBar.
  ///
  /// - Remember the [SideBar] is rotated and placed in the Page.
  /// - So the height of a non-transformed Container becomes [verticalWidth].
  final double verticalWidth;

  /// Background color of the [SideBar].
  final Color? sideBarColor;

  /// Widgets that will go inside the [SideBar]
  ///
  /// ### Note:
  ///   - To make the children widgets parallel to the screen use [RotatedBox] with each child.
  ///   - Normally, [verticalHeight] would be maximum width of all the children in total.
  ///   - Normally,[verticalWidth] would be the maximum height of each child widget.
  final List<Widget> children;

  /// Text Direction for the widgets to be laid.
  final TextDirection? textDirection;

  /// This specifies how the children will be laid the horizontal axis of the sidebar.
  final MainAxisAlignment mainAxisAlignment;

  /// This specifies how the children will be laid the vertical axis of the sidebar.
  final CrossAxisAlignment crossAxisAlignment;

  /// Flips the SideBar with the children.
  final bool flip;

  const SideBar({
    Key? key,
    this.alignment = Alignment.centerLeft,
    required this.verticalHeight,
    required this.verticalWidth,
    this.sideBarColor = Colors.transparent,
    required this.children,
    this.flip = false,
    this.textDirection = TextDirection.ltr,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Widget build(BuildContext context) {
    return Semantics(
      label: 'sidebar',
      child: RotatedBox(
        quarterTurns: !widget.flip ? 3 : 1,
        child: Container(
          height: widget.verticalWidth,
          width: widget.verticalHeight,
          color: widget.sideBarColor,
          alignment: widget.alignment,
          child: Row(
            textDirection: widget.textDirection,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisAlignment: widget.mainAxisAlignment,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}

/// @note: note in use.
// @visibleForTesting
// class SideBarAlignment {
//   /// Stores the Alignment of the [SideBar] on the Screen.
//   final Position position;
//
//   PosValue _posValue = PosValue();
//
//   SideBarAlignment({this.position = Position.left});
//
//   /// Positions the [Sidebar] to [left] or [right].
//   SideBarAlignment.align({required this.position});
//
//   /// Returns the value for [top] and [left] or [right] for [Positioned] widget.
//   /// Depending on the [_value] of position.
//   PosValue get sideBarPosition {
//     switch (this.position) {
//       case Position.left:
//         _posValue = PosValue(left: 0.0, right: null, top: 0.0);
//         break;
//       case Position.right:
//         _posValue = PosValue(left: null, right: 0.0, top: 0.0);
//         break;
//     }
//     return _posValue;
//   }
// }
//
// /// Class to enclose the Position values for the [SideBar] alignment.
// class PosValue {
//   final double? left;
//   final double? right;
//   final double top;
//
//   const PosValue({this.left = 0.0, this.right = double.maxFinite, this.top = 0.0}) : assert(left == 0.0 || right == 0.0, 'only one of the left or right should be 0.0');
// }
