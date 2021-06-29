import 'dart:math' show Random;
import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;

/// Creates connected line pattern that changes position in time, creating a futuristic tech pattern effect.
class TechnologicalLinesAnimation extends StatefulWidget {
  /// Scales the widget to the specified value, default is 1.
  final double scale;

  /// ScrollDirection to trigger the animation.
  final ScrollDirection scrollDirection;

  const TechnologicalLinesAnimation({Key? key, this.scale = 1, required this.scrollDirection}) : super(key: key);

  _TechnologicalLinesAnimationState createState() => _TechnologicalLinesAnimationState();
}

class _TechnologicalLinesAnimationState extends State<TechnologicalLinesAnimation> with TickerProviderStateMixin {
  /// Animation Controller for different nodes.
  late final AnimationController _lineAnimationController1;
  late final AnimationController _lineAnimationController2;
  late final AnimationController _lineAnimationController3;

  /// Animation Controller to change the size of circle.
  late final AnimationController _circleRadAnimationController;

  /// Position change type 1.
  late Animation<double> _posOff1;

  /// Position change of type 2.
  late Animation<double> _posOff2;

  /// Position change of type 3.
  late Animation<double> _posOff3;

  /// Change of circle radius.
  late Animation<double> _radTranslate;

  @override
  void initState() {
    _lineAnimationController1 = AnimationController(vsync: this, duration: Duration(seconds: 1, milliseconds: 200));
    _lineAnimationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    _lineAnimationController3 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _circleRadAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _posOff1 = Tween<double>(begin: 1, end: 7).animate(_lineAnimationController1);
    _posOff2 = Tween<double>(begin: -6, end: 1).animate(_lineAnimationController2);
    _posOff3 = Tween<double>(begin: 6, end: -6).animate(_lineAnimationController3);
    _radTranslate = Tween<double>(begin: 0, end: 4).animate(_circleRadAnimationController);

    _lineAnimationController1.repeat(reverse: true);
    _lineAnimationController2.repeat(reverse: true);
    _lineAnimationController3.repeat(reverse: true);
    _circleRadAnimationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _lineAnimationController1.dispose();
    _lineAnimationController2.dispose();
    _lineAnimationController3.dispose();
    _circleRadAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Container(
        height: 500.0,
        width: 850.0,
        child: CustomPaint(
          size: Size(850, 500),
          painter: _TechLinesPainter(context, [_posOff1, _posOff2, _posOff3, _radTranslate]),
          isComplex: true,
          willChange: true,
        ),
      ),
    );
  }
}

class _TechLinesPainter extends CustomPainter {
  /// Radius of the circle of the segment intersection.
  static const double _rad = 5.0;

  /// Origin co-ordinate point for the Segments
  static const Offset _origin = Offset(10.0, 8.0);

  /// A multiplier, which is multiplied with the [change] item.
  static const int _mul = 7;

  /// BuildContext of the widget where [TechnologicalLinesAnimation] is passed as child.
  final BuildContext context;

  /// List of Animated double to create variable moving animations.
  final List<Animation<double>> change;

  /// Random object.
  final Random _random = Random(5);

  //constructor
  _TechLinesPainter(this.context, this.change);

  /// Creates and gradient with the specified [start] and [end] co-ordinates.
  Paint _gradientPaint(Offset start, Offset end) {
    // translating the specified offset so that the gradient looks organic.
    Offset _start = Offset(start.dx + 5.0, start.dy + 5.0);
    Offset _end = Offset(end.dx + 5.0, end.dy + 5.0);
    return Paint()
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        _start,
        _end,
        [Theme.of(context).highlightColor.withOpacity(0.3), Theme.of(context).primaryColor.withOpacity(0.6)],
        [0.4, 1.0],
      );
  }

  /// Creates an circle at the segment intersection.
  void drawPoint(Canvas canvas, Offset center) {
    /// List of Paint to pass it to the segment circles.
    List<Paint> _dotPaint = [
      Paint()..color = Theme.of(this.context).highlightColor.withOpacity(0.6),
      Paint()..color = Theme.of(this.context).primaryColor.withOpacity(0.6),
      Paint()..color = Theme.of(this.context).accentColor
    ];

    //canvas.drawCircle(center, _rad + this.change[3].value, Paint()..color = Theme.of(context).primaryColor.withOpacity(0.4));
    //canvas.drawCircle(center, _rad + this.change[3].value, Paint()..color = Theme.of(context).highlightColor.withOpacity(0.5));
    canvas.drawCircle(center, _rad, _dotPaint[_random.nextInt(3)]);
  }

  /// Creates a line between the specified points, [point1] and [point2].
  void _segment(Canvas canvas, Offset point1, Offset point2) => canvas.drawLine(point1, point2, _gradientPaint(point1, point2));

  @override
  void paint(Canvas canvas, Size size) {
    ///
    final double _posChange1 = _mul * change[0].value;
    final double _posChange2 = _mul * change[1].value;
    final double _posChange3 = _mul * change[2].value;

    /// A 2D array with co-ordinates of points of intersection of segments
    final List<List<Offset>> _points = [
      // start
      [_origin],
      // level1
      [
        Offset(180 + _posChange1, 10 + _posChange1),
        Offset(100 + _posChange2, 50 + _posChange3),
        Offset(135 + _posChange2, 180 + _posChange2),
        Offset(110 + _posChange3, 300 + _posChange3),
      ],
      // level2
      [
        Offset(350 + _posChange2, 120 + _posChange1),
        Offset(345 + _posChange1, 250 + _posChange2),
        Offset(300 + _posChange1, 280 + _posChange3),
      ],
      // level 3
      [
        Offset(460 + _posChange3, 200 + _posChange1),
        Offset(445 + _posChange3, 320 + _posChange3),
      ],
      // level 4
      [
        Offset(600 + _posChange1, 70 + _posChange2),
        Offset(550 + _posChange2, 260 + _posChange1),
        Offset(580 + _posChange1, 300 + _posChange2),
        Offset(500 + _posChange3, 350 + _posChange1),
      ],
      // end
      [Offset(750, 450)],
    ];

    //segments

    // start node ---> level1
    _segment(canvas, _points[0][0], _points[1][0]);
    _segment(canvas, _points[0][0], _points[1][1]);
    _segment(canvas, _points[0][0], _points[1][2]);
    _segment(canvas, _points[0][0], _points[1][3]);

    //level1 ---> level2
    _segment(canvas, _points[1][0], _points[2][0]);
    _segment(canvas, _points[1][1], _points[2][0]);
    _segment(canvas, _points[1][1], _points[2][1]);
    _segment(canvas, _points[1][2], _points[2][1]);
    _segment(canvas, _points[1][2], _points[2][2]);
    _segment(canvas, _points[1][3], _points[2][2]);

    // level 2 ---> level3
    _segment(canvas, _points[2][0], _points[3][0]);
    _segment(canvas, _points[2][1], _points[3][0]);

    _segment(canvas, _points[2][2], _points[3][1]);
    _segment(canvas, _points[2][1], _points[3][1]);
    //level1 ---> level3
    _segment(canvas, _points[1][3], _points[3][1]);

    //level3 ---> level4
    _segment(canvas, _points[3][0], _points[4][0]);
    _segment(canvas, _points[3][0], _points[4][2]);
    _segment(canvas, _points[3][0], _points[4][1]);

    _segment(canvas, _points[3][1], _points[4][1]);
    _segment(canvas, _points[3][1], _points[4][3]);
    // level2 ---> level4
    _segment(canvas, _points[2][0], _points[4][0]);

    // level4---> end node
    _segment(canvas, _points[4][0], _points[5][0]);
    _segment(canvas, _points[4][1], _points[5][0]);
    _segment(canvas, _points[4][2], _points[5][0]);
    _segment(canvas, _points[4][3], _points[5][0]);

    //cross segments

    //level 1
    _segment(canvas, _points[1][0], _points[1][1]);
    _segment(canvas, _points[1][1], _points[1][2]);
    _segment(canvas, _points[1][2], _points[1][3]);

    // level2
    _segment(canvas, _points[2][0], _points[2][1]);
    _segment(canvas, _points[2][1], _points[2][2]);

    // level3
    _segment(canvas, _points[3][0], _points[3][1]);

    // level4
    _segment(canvas, _points[4][0], _points[4][2]);
    _segment(canvas, _points[4][2], _points[4][1]);
    _segment(canvas, _points[4][1], _points[4][3]);

    //circles
    //start node
    drawPoint(canvas, _points[0][0]);

    //level 1
    drawPoint(canvas, _points[1][0]);
    drawPoint(canvas, _points[1][1]);
    drawPoint(canvas, _points[1][2]);
    drawPoint(canvas, _points[1][3]);

    //level 2
    drawPoint(canvas, _points[2][0]);
    drawPoint(canvas, _points[2][1]);
    drawPoint(canvas, _points[2][2]);

    //level 3
    drawPoint(canvas, _points[3][0]);
    drawPoint(canvas, _points[3][1]);

    //level 4
    drawPoint(canvas, _points[4][0]);
    drawPoint(canvas, _points[4][1]);
    drawPoint(canvas, _points[4][2]);
    drawPoint(canvas, _points[4][3]);

    //end node
    drawPoint(canvas, _points[5][0]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
