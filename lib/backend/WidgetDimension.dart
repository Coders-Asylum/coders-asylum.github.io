import 'package:flutter/widgets.dart' show EdgeInsets, Size;

/// Holds the common dimension parameters needed to create Widget
///
class WidgetDimension extends Size {
  /// height of the widget.
  final double height;

  /// Width of the widget.
  final double width;

  /// Margin dimensions of the widget.
  final EdgeInsets margin;

  /// Padding dimensions of the widget.
  final EdgeInsets padding;

  const WidgetDimension({this.height = 0.0, this.width = 0.0, this.margin = const EdgeInsets.all(0.0), this.padding = const EdgeInsets.all(0.0)}) : super(width, height);

  @override
  String toString() {
    return 'Dimension: height = ${this.height}, width = ${this.width}, margin = ${this.margin.toString()}, padding = ${this.padding.toString()}';
  }
}
