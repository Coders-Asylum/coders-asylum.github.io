import 'package:flutter/material.dart';

/// Creates a circles in rows and columns, making a circle matrix pattern.
class CircleMatrix extends StatefulWidget {
  _CircleMatrixState createState() => _CircleMatrixState();
}

class _CircleMatrixState extends State<CircleMatrix> {
  /// No of Rows of Circles
  static const int _rows = 6;

  /// No. of Columns of Circles.
  static const int _columns = 6;

  /// This is the spacing around each each circle.
  ///
  /// The [_off] value is sum of left and right or top and bottom spacing.
  static const double _off = 20.0;
  static const double _radius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _columns * (_radius * 2 + _off),
      width: _rows * (_radius * 2 + _off),
      child: CustomPaint(
        size: Size(_rows * (_radius * 2 + _off), _columns * (_radius * 2 + _off)),
        painter: _CirclesPainter(row: _rows, column: _columns, radius: _radius, spacing: _off / 2),
      ),
    );
  }
}

/// Painter Class to paint the circle matrix
class _CirclesPainter extends CustomPainter {
  /// List of colours the pattern will be iterated to expand vertically.
  static const List<Color> _colors = [Color(0xffC4C4C4), Color(0xff5A5A5A), Color(0xff313131), Color(0xff232323)];

  /// No. of rows of circles.
  final int row;

  /// No. of Columns of Circles.
  final int column;

  /// The radius of the circles
  final double radius;

  /// Space before or on top of each circle.
  final double spacing;

  _CirclesPainter({required this.row, required this.column, required this.radius, required this.spacing});

  /// Paints a circle matrix pattern of [row] and [column].
  void _circleBlock(Canvas canvas, Color color, double yOff) {
    // Paint with [color]
    final Paint _paint = Paint()..color = color;

    /// Horizontal spacing before each circle.
    double _xSpace = this.spacing + this.radius;

    /// Vertical spacing before each circle.
    double _ySpace = this.spacing + this.radius + yOff;

    for (int i = 0; i < this.column; i++) {
      for (int j = 0; j < this.row; j++) {
        canvas.drawCircle(Offset(_xSpace, _ySpace), this.radius, _paint);

        _xSpace += this.spacing + this.radius * 2;
      }
      _xSpace = this.spacing + this.radius;
      _ySpace += this.spacing + this.radius * 2;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    int _c = 0;
    _colors.forEach((color) {
      _circleBlock(canvas, color, _c * (this.column * (this.radius * 2 + this.spacing)));
      _c++;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
