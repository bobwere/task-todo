import 'package:flutter/material.dart';

///
class AppDropdown extends StatelessWidget {
  ///
  const AppDropdown({
    required this.dropdownButtonWidget,
    required this.menuWidget,
    required this.controller,
    required this.link,
    this.onPressed,
    super.key,
  });

  ///
  final Widget menuWidget;

  ///
  final Widget dropdownButtonWidget;

  ///
  final OverlayPortalController controller;

  ///
  final LayerLink link;

  ///
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: controller,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: link,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: menuWidget,
            ),
          );
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            controller.toggle();
            onPressed?.call();
          },
          child: dropdownButtonWidget,
        ),
      ),
    );
  }
}
