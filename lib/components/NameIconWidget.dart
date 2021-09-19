import 'package:flutter/material.dart';

/// Creates an profile image icon with the first letter of the [name].
///
/// The first letter is shown inside a circle with border.
class NameIcon extends StatelessWidget {
  /// Name of the person/user.
  final String name;

  /// Background colour behind the text
  final Color backgroundColor;

  /// Color of the letter showed as icon.
  final Color textColor;

  const NameIcon({
    Key? key,
    required this.name,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  /// Returns the first letter of the string [name].
  String get firstLetter => this.name.substring(0, 1).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: this.backgroundColor,
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 0.5)),
        padding: EdgeInsets.all(8.0),
        child: Text(this.firstLetter,
            style: TextStyle(fontFamily: 'Gobold', color: this.textColor)),
      ),
    );
  }
}
