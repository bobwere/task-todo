import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/app_loader.dart';
import 'package:todo_app/shared/constant/app_colors.dart';
import 'package:todo_app/shared/constant/app_spacing.dart';
import 'package:todo_app/shared/util/ui_util.dart';

///
class AppButton extends StatelessWidget {
  ///
  const AppButton.primary({
    super.key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.fullWidth = true,
    this.isLoading = false,
    this.buttonTextStyle,
  }) : assert(
          label != null || prefixIcon != null,
          'Label or icon must be provided.',
        );

  ///
  final String? label;

  ///
  final Widget? prefixIcon;

  ///
  final Widget? suffixIcon;

  ///
  final VoidCallback? onPressed;

  ///
  final bool? fullWidth;

  ///
  final EdgeInsets? padding;

  ///
  final TextStyle? buttonTextStyle;

  ///
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing();
    final ui = UiUtil(context);
    final colors = AppColors();

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) prefixIcon!,
        if (prefixIcon != null && label != null)
          SizedBox(width: spacing.spacing4),
        if (label != null)
          Text(
            label!,
            textAlign: TextAlign.center,
            style: buttonTextStyle,
            textScaler: TextScaler.linear(
              ui.textScaleFactor,
            ),
          ),
        if (suffixIcon != null) SizedBox(width: spacing.spacing4),
        if (suffixIcon != null) suffixIcon!,
      ],
    );

    return Padding(
      padding: padding!,
      child: SizedBox(
        width: fullWidth! ? MediaQuery.of(context).size.width : null,
        height: ui.scaleHeightFactor(45),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: ui.colors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: isLoading
              ? appLoader(
                  size: 16,
                  color: colors.background,
                )
              : child,
        ),
      ),
    );
  }
}
