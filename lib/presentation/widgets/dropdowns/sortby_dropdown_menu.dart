// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class SortbyDropdownMenu extends StatelessWidget {
  const SortbyDropdownMenu({
    required this.controller,
    required this.onItemPressed,
    super.key,
  });

  final OverlayPortalController controller;
  final void Function(String value) onItemPressed;

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ui.scaleWidthFactor(16),
        vertical: ui.scaleHeightFactor(8),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ui.scaleWidthFactor(16),
        vertical: ui.scaleWidthFactor(8),
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFFE2E7F1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            offset: Offset(ui.scaleWidthFactor(6), ui.scaleHeightFactor(6)),
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Highest Priority',
          'Least Priority',
          'Most Recent Creation Date',
          'Least Recent Creation Date'
        ]
            .map(
              (type) => InkWell(
                onTap: () {
                  onItemPressed(type);
                  controller.toggle();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    type,
                    style: ui.textStyle
                        .bodyMedium()
                        .copyWith(color: ui.colors.primary),
                    textScaler: TextScaler.linear(ui.textScaleFactor),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
