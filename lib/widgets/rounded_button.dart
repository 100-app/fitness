// ignore_for_file: overridden_fields, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class RoundedButton extends RaisedButton {
  @override
  final VoidCallback onPressed;
  @override
  final Widget child;
  @override
  final Color color;
  final double bordeRadius;
  final double width;
  @override
  final double height;

  // ignore: duplicate_ignore
  const RoundedButton(
      {required this.onPressed,
      required this.child,
      required this.color,
      required this.bordeRadius,
      required this.width,
      required this.height})
      : super(onPressed: onPressed, child: child);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(bordeRadius)),
              buttonColor: color,
              minWidth: width,
              height: height,
            ),
      ),
      child: Builder(builder: super.build),
    );
  }
}
