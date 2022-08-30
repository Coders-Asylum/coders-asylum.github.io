import 'package:flutter/material.dart';

/// A parent class for [WidgetConstraints] and other constraints that contains all dimensional information.
///
@immutable
abstract class Constraint {
  Constraint();

  double get _height;
  double get _width;
  EdgeInsets get _padding;
  EdgeInsets get _margin;

  ///todo: create methods to get child distance from right left top and bottom, by adding padding and margin data.
  /// also a method to check if edgeinsets geometry and other dimensions are zero.

  dynamic operator [](String constraint);
}

class WidgetConstraints extends Constraint {
  late final double width;
  late final double height;
  late final EdgeInsets padding;
  late final EdgeInsets margin;
  late final Map<String, dynamic> _constraints;

  WidgetConstraints({required double width, required double height, EdgeInsets padding = EdgeInsets.zero, EdgeInsets margin = EdgeInsets.zero}) {
    this.height = height;
    this.width = width;
    this.padding = padding;
    this.margin = margin;
    this._constraints = {"width": this._width, "height": this._height, "padding": this._padding, "margin": this._margin};
  }

  WidgetConstraints.map({required Map<String, dynamic> constraints}) {
    WidgetConstraints(height: constraints['height'], width: constraints['width'], padding: constraints['padding'], margin: constraints['margin']);
  }

  @override
  dynamic operator [](String constraint) {
    return this._constraints[constraint];
  }

  @override
  double get _height => this.height;

  @override
  EdgeInsets get _margin => this.margin;

  @override
  EdgeInsets get _padding => this.padding;

  @override
  double get _width => this.width;
}
