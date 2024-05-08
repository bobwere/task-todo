// ignore_for_file: avoid_multiple_declarations_per_line, library_private_types_in_public_api, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/shared/util/ui_util.dart';

///
class AppInput extends StatefulWidget {
  ///
  const AppInput({
    required this.textEditingController,
    super.key,
    this.validator,
    this.inputFormatters = const [],
    this.enabled,
    this.onChanged,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.hint,
    this.prefixWidget,
    this.obscureText,
    this.suffixWidget,
    this.textInputType,
    this.label,
    this.error,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.onTap,
  });

  ///
  final String? label;

  ///
  final void Function(String value)? onChanged;

  ///
  final VoidCallback? onTap;

  ///
  final TextInputType? textInputType;

  ///
  final int? maxLength, maxLines, minLines;

  ///
  final TextEditingController textEditingController;

  ///
  final bool? obscureText;

  ///
  final String? hint;

  ///
  final bool? enabled;

  ///
  final String? Function(String?)? validator;

  ///
  final Widget? suffixWidget;

  ///
  final Widget? prefixWidget;

  ///
  final List<TextInputFormatter>? inputFormatters;

  ///
  final EdgeInsets? padding;

  ///
  final String? error;

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);

    return Padding(
      padding: widget.padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null)
            Text(
              widget.label!,
              style: ui.textStyle.labelLarge(),
              textScaler: TextScaler.linear(ui.textScaleFactor),
            ),
          if (widget.label != null)
            SizedBox(height: ui.scaleHeightFactor(ui.spacing.spacing8)),
          TextFormField(
            enabled: widget.enabled ?? true,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            inputFormatters: widget.inputFormatters,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            controller: widget.textEditingController,
            obscureText: widget.obscureText ?? false,
            style: ui.textStyle.bodyMedium(),
            decoration: InputDecoration(
              prefixIcon: widget.prefixWidget,
              hintText: widget.hint ?? '',
              suffixIcon: widget.suffixWidget,
            ),
          ),
          if (widget.error != null && widget.error!.isNotEmpty)
            SizedBox(height: ui.scaleHeightFactor(ui.spacing.spacing4)),
          if (widget.error != null && widget.error!.isNotEmpty)
            Text(
              widget.error!,
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
