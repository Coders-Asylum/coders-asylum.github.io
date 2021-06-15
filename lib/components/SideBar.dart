import 'dart:math' show pi;

import 'package:flutter/material.dart';

/// todo(@maverick099): Create a class for SideBarItems/Tabs.
/// todo(@maverick099): The SideBarItems/Tabs should be able to navigate to page or launch Url.

/// Positions of the SideBar.
enum Position { left, right }

/// Creates the SideBar that goes either on the Left or Right of the Screen.
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
  final Widget? child;

  /// Flips the SideBar with the children.
  final bool flip;

  const SideBar({
    Key? key,
    this.alignment = Alignment.centerLeft,
    required this.verticalHeight,
    required this.verticalWidth,
    this.sideBarColor = Colors.transparent,
    this.child,
    this.flip = false,
  }) : super(key: key);

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        height: widget.verticalWidth,
        width: widget.verticalHeight,
        color: widget.sideBarColor,
        alignment: widget.alignment,
        child: widget.child,
      ),
    );
  }
}

/// todo(@maverick099): add this as a parameter while constructing the page template.
/// todo(@maverick099): remember to take in consideration of the width of different widgets while using the sidebar in the stack
class SideBarAlignment {
  /// Stores the Alignment of the [SideBar] on the Screen.
  final Position _value;

  late final PosValue _posValue;

  /// Positions the [Sidebar] to [left] or [right].
  SideBarAlignment.align(Position pos) : _value = pos;

  /// Returns the value for [top] and [left] or [right] for [Positioned] widget.
  /// Depending on the [_value] of position.
  PosValue get sideBarPosition {
    switch (_value) {
      case Position.left:
        _posValue = PosValue(left: 0.0, right: null, top: 0.0);
        break;
      case Position.right:
        _posValue = PosValue(left: null, right: 0.0, top: 0.0);
        break;
    }
    return _posValue;
  }
}

/// Class to enclose the Position values for the [SideBar] alignment.
class PosValue {
  final double? left;
  final double? right;
  final double top;

  const PosValue({this.left = 0.0, this.right = double.maxFinite, this.top = 0.0})
      : assert(left == 0.0 || right == 0.0, 'only one of the left or right should be 0.0');
}
