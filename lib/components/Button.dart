import 'package:flutter/material.dart';
import 'package:web/components/paint/ButtonAnimation.dart' show ButtonAnimationPainter;

/// A Custom Button with Curtain closing animation on Hover.
class Button extends StatefulWidget {
  /// Height of the Button.
  final double height;

  /// Width of the Button.
  final double width;

  /// The text/name of the button.
  ///
  /// This is displayed in center of the button.
  final String text;

  /// Function called when the button is pressed.
  final VoidCallback? onPressed;

  const Button({Key? key, required this.height, required this.width, required this.text, this.onPressed}) : super(key: key);

  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  /// Animation controller
  late final AnimationController _animationController;

  /// curtain 1 animated double.
  late final Animation<double> _animatedHeight1;

  /// curtain 2 animated double.
  late final Animation<double> _animatedHeight2;

  /// curtain 3 animated double.
  late final Animation<double> _animatedHeight3;

  /// change in border and shadow opacity on Hover.
  ///
  /// Border disappears  and shadows appear on hover.
  late final Animation<double> _animatedOpacity;

  /// A multiplier that is subtracted with the ```begin:``` parameter of [Tween].
  /// This creates an delay effect since there is more distance to travel to reach ```end:```.
  static const double _mul = 50.0;

  /// Corner radius of the button.
  static const double _buttonCornerRadius = 12.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _animatedOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    _animatedHeight1 = Tween<double>(end: widget.height, begin: 0.0).animate(_animationController);
    _animatedHeight2 = Tween<double>(end: widget.height, begin: 0.0 - _mul).animate(_animationController);
    _animatedHeight3 = Tween<double>(end: widget.height, begin: 0.0 - _mul * 2).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(_buttonCornerRadius),
        boxShadow: [
          BoxShadow(color: Theme.of(context).shadowColor.withOpacity(1 - _animatedOpacity.value), offset: Offset(-1, -1), blurRadius: 6.0),
          BoxShadow(color: Theme.of(context).shadowColor.withOpacity(1 - _animatedOpacity.value), offset: Offset(4, 4), blurRadius: 10.0)
        ],
      ),
      child: MouseRegion(
        onEnter: (event) => _animationController.forward(),
        onExit: (event) => _animationController.reverse(),
        child: CustomPaint(
          painter: ButtonAnimationPainter([_animatedHeight1, _animatedHeight2, _animatedHeight3], widget.width, widget.height, context),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_buttonCornerRadius),
              border: Border.all(color: Theme.of(context).highlightColor.withOpacity(_animatedOpacity.value), width: 2.0),
            ),
            child: TextButton(
              onPressed: () {
                print('button tapped');
                widget.onPressed!();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(2.0)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  widget.text,
                  style: TextStyle(fontFamily: 'Source Code', color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
