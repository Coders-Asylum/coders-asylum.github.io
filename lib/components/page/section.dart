import 'package:flutter/material.dart' ;
import 'package:web/data/Constraints.dart';

class Section extends StatefulWidget {
  /// current Widget dimemsion.
  final WidgetConstraints widgetConstraints;

  /// Child widget.
  final Widget childWidget;

  const Section({Key? key, required this.widgetConstraints, required this.childWidget}) : super(key: key);

  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width, height: widget.widgetConstraints.height, padding: widget.widgetConstraints.padding, margin: widget.widgetConstraints.margin, color: Colors.transparent, child: widget.childWidget);
  }
}
