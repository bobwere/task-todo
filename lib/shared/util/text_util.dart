import 'package:flutter/material.dart';
import 'package:todo_app/shared/constant/app_spacing.dart';

SizedBox spacerHorizontal(double spacing) => SizedBox(
      width: spacing,
    );

SizedBox spacerVertical(double spacing) => SizedBox(
      height: spacing,
    );

class VerticalPadding extends StatelessWidget {
  const VerticalPadding({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.spacing16),
      child: child,
    );
  }
}

/// capitalize first word only e.g if [input] is fEVER output is Fever
String capitalizeFirstWordOnly(String input) {
  if (input.isEmpty) {
    return input;
  }

  return '${input.substring(0, 1).toUpperCase()}${input.substring(1).toLowerCase()}';
}
