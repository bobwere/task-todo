import 'package:flutter/material.dart';

///
class KeyboardDismiss extends StatelessWidget {
  ///
  const KeyboardDismiss({
    required this.child,
    super.key,
  });

  ///
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}
