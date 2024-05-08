import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:todo_app/shared/constant/app_strings.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class FilterbyDropdownButton extends StatelessWidget {
  const FilterbyDropdownButton({
    required this.value,
    required this.errorMsg,
    super.key,
  });

  final String? value;
  final String? errorMsg;

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ui.scaleWidthFactor(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filterBy,
            style: ui.textStyle.labelLarge(),
            textScaler: TextScaler.linear(ui.textScaleFactor),
          ),
          SizedBox(height: ui.scaleHeightFactor(ui.spacing.spacing8)),
          Container(
            height: ui.scaleHeightFactor(45),
            width: ui.scaleWidthFactor(120),
            padding: EdgeInsets.symmetric(horizontal: ui.scaleWidthFactor(12)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ui.colors.primary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    value != null && value!.isNotEmpty ? value! : hintFilterBy,
                    maxLines: 1,
                    style: ui.textStyle.bodyMedium().copyWith(
                          color: value != null && value!.isNotEmpty
                              ? ui.colors.onBackground
                              : ui.colors.subTextColor,
                        ),
                  ),
                ),
                Transform.rotate(
                  angle: -math.pi / 2,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: ui.colors.primary,
                    size: ui.scaleWidthFactor(18),
                  ),
                ),
              ],
            ),
          ),
          if (errorMsg != null && errorMsg!.isNotEmpty)
            SizedBox(height: ui.scaleHeightFactor(ui.spacing.spacing4)),
          if (errorMsg != null && errorMsg!.isNotEmpty)
            Text(
              errorMsg!,
              style: ui.textStyle.bodySmall().copyWith(
                    color: ui.colors.error,
                  ),
              textScaler: TextScaler.linear(ui.textScaleFactor),
            ),
        ],
      ),
    );
  }
}
