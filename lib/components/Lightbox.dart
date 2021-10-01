import 'dart:ui' as ui show ImageFilter, Gradient;
import 'package:flutter/material.dart';

/// A Light-box is a dialog window, that appears on top of a webpage when a visitor is browsing.
/// It dims the background with an overlay and partially disables the content.
/// Visitors cannot interact with the webpage content until they close the lightbox popup.
///
/// The [LightBox] can be called immediately using [LightBox.show(context)]
/// or after a delay using [LightBox.showDelayed(context, delay)].
class LightBox {
  /// The title for the lightbox a required parameter.
  /// This should highlight the main message behind the light-box being displayed.
  final String title;

  /// This string is an extended message in context with the title of the lightbox.
  final String? content;

  /// The path of image/gif inside the asset folders, this image should be in context of the message being displayed in the light box.
  ///
  /// The Image/GIF should be witty, comic or laughable. Using memes is also encouraged to keep the website user-friendly.
  /// New images should follow the location structure as mentioned on the contribution guidelines.
  final String path;

  /// Corner radius for the light box.
  static const Radius _cRadius = Radius.circular(12.0);
  /// Blur strength.
  static const double _blur = 40.0;
  /// Content box body and border color.
  static const Color _cColor = Color(0xffCCCCCC);


  LightBox(this.title, this.content, this.path);

  /// Displays the Lightbox immediately as soon as it is this is called.
  /// Waits for the widget to bind in the given [context] i.e: Widgets of the current context to be populated in the tree.
  LightBox.show(BuildContext context, {required this.title, this.path = './lib/assets/cat_working_hard.gif', this.content}) {
    WidgetsBinding.instance!.addPostFrameCallback((Duration _) {
      showDialog(context: context, builder: (BuildContext context) => this.lightBoxDialog(context));
    });
  }

  /// When called the light box is displayed with an delay. [delay] parameter time controls after how much delay the light box is displayed
  LightBox.showDelayed(BuildContext context, Duration delay, {required this.title , this.path = './lib/assets/cat_working_hard.gif', this.content}) {
    Future.delayed(delay, () => LightBox.show(context, title: title,content: this.content,path: this.path));
  }

  /// Light box Widget UI structure.
  Widget lightBoxDialog(BuildContext context) {
    return Semantics(
      label: 'lightbox',
      child: Center(
        child: Material(
          color: Colors.transparent,
          elevation: 8.0,
          child: Container(
            width: 815,
            height: this.content != null ? 602.0 : 400.0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipRect(
                  child: Container(
                    height: 250,
                    width: 660,
                    decoration: ShapeDecoration(shape: LightBoxCustomShape()),
                    child: BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: _blur, sigmaY: _blur)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // title
                    Container(
                      height: 250,
                      width: 417,
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close_rounded, size: 30.0, color: Colors.redAccent),
                              splashRadius: 25.0,
                              alignment: Alignment.center,
                              hoverColor: Colors.blue.withOpacity(0.3),
                              splashColor: Colors.red.withOpacity(0.8),
                            ),
                          ),
                          //  Title text
                          Container(
                            height: 160,
                            width: 417,
                            //color: Colors.red,
                            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                              child: Text(this.title, textDirection: TextDirection.ltr, textAlign: TextAlign.left, style: TextStyle(color: Colors.white,fontFamily: 'Gobold')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // image
                    Container(
                      height: 398,
                      width: 398,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.5),
                        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: this.content == null ? false : true,
                  child: Positioned(
                    left: 0.0,
                    bottom: 95,
                    child: Container(
                      height: 120.0,
                      width: 795.0,
                      decoration: BoxDecoration(
                        color: _cColor,
                        borderRadius: BorderRadius.only(topLeft: _cRadius, bottomLeft: _cRadius, bottomRight: _cRadius),
                        border: Border.all(color: _cColor, width: 2.0, style: BorderStyle.solid),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Text(this.content != null ? this.content! : "", softWrap: true, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// todo: implement the scale variable.
/// A custom shape border class for the light box.
class LightBoxCustomShape extends ShapeBorder {
  /// The blur strength for background blur.
  static const double blur = 40.0;

  /// Corner Radius for the light box shape.
  static const double cornerRadius = 12.0;

  /// Scale factor.
  late final double _s;

  ///Gradient background colors.
  final List<Color> gradientColor = [const Color(0xff525252).withOpacity(0.4), Color(0xffFFFFFF).withOpacity(0.4)];

  LightBoxCustomShape() {
    _s = 1;
  }

  /// scales the shape border with a factor of [s].
  LightBoxCustomShape.scale(double s) {
    this._s = s;
  }

  /// Border path for both inner and outer border of the custom shape.
  /// [outer] boolean is used to specify the function if the path to be returned for inner or outer border,
  /// true for outer border.
  Path _borderPath(Rect rect, bool outer) {
    final Path _p = Path();
    _p.moveTo(rect.left + _s * cornerRadius, rect.top);
    _p.lineTo(rect.right - 200, rect.top);
    _p.arcToPoint(Offset(rect.right - 200, rect.bottom), radius: Radius.circular(200), clockwise: outer, largeArc: outer);
    _p.lineTo(rect.left + _s * cornerRadius, rect.bottom);
    _p.quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - _s * cornerRadius);
    _p.lineTo(rect.left, rect.top + _s * cornerRadius);
    _p.quadraticBezierTo(rect.left, rect.top, rect.left + _s * cornerRadius, rect.top);
    return _p;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(8.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _borderPath(rect, false);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _borderPath(rect, true);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // final Paint _blurPaint = Paint()
    //   ..imageFilter = ui.ImageFilter.blur(sigmaY: blur, sigmaX: blur);

    final Paint _bodyPaint = Paint()
      ..shader = ui.Gradient.linear(rect.topLeft, rect.bottomRight, [Color(0xff525252).withOpacity(0.4), Color(0xffFFFFFF).withOpacity(0.4)])
      ..imageFilter = ui.ImageFilter.blur(sigmaY: blur, sigmaX: blur);

    final Paint _border = Paint()
      ..style = PaintingStyle.stroke
      ..shader = ui.Gradient.linear(rect.topLeft, rect.bottomRight, [Color(0xff525252).withOpacity(0.4), Color(0xffFFFFFF).withOpacity(0.4)])
      ..strokeWidth = 2.0;

    canvas.drawPath(_borderPath(rect, true), _bodyPaint);
    //canvas.drawPath(_borderPath(rect,true), _blurPaint);
    canvas.drawPath(_borderPath(rect, true), _border);
    canvas.drawPath(_borderPath(rect, false), _border);
  }

  @override
  ShapeBorder scale(double t) {
    return LightBoxCustomShape.scale(t);
  }
}
