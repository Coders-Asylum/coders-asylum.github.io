import 'package:flutter/material.dart';

/// Custom painter to paint  closing curtain effect.
class ButtonAnimationPainter extends CustomPainter {
  /// The change in height over time.
  final List<Animation<double>> translate;

  /// Width of the button.
  final double width;

  /// Height of the button.
  final double height;

  /// Context of the current state.
  final BuildContext context;

  ButtonAnimationPainter(
    this.translate,
    this.width,
    this.height,
    this.context,
  );

  /// Returns curtain Rectangle in according to the position in the button.
  Rect _blockRect(int i, Animation<double> translate) {
    final double _blockWidth = this.width / 3;
    return Rect.fromLTRB(_blockWidth * i, translate.value, _blockWidth * (i + 1) + 0.5, 0.0);

    //Rect.fromPoints(Offset(_blockWidth * i, this.height), Offset(_blockWidth * (i + 1), translate.value));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _blockPaint = Paint()..color = Theme.of(context).accentColor;

    for (int i = 0; i < 3; i++) {
      canvas.drawRect(_blockRect(i, translate[i]), _blockPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
