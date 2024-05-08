import 'package:flutter/material.dart';
import 'package:todo_app/shared/constant/app_colors.dart';
import 'package:todo_app/shared/constant/app_spacing.dart';
import 'package:todo_app/shared/constant/app_strings.dart';
import 'package:todo_app/shared/util/textstyle_util.dart';

class UiUtil {
  const UiUtil(this.context);
  final BuildContext context;

  //
  AppSpacing get spacing => AppSpacing();
  AppColors get colors => AppColors();

  //
  AppTextStyles get textStyle => AppTextStyles();

  //
  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  double get scale => mockUpWidth / width;

  double get textScaleFactor => width / mockUpWidth;

  double scaleWidthFactor(double inputWidth) =>
      inputWidth / mockUpWidth * width;

  double scaleHeightFactor(double inputWidth) =>
      inputWidth / mockUpHeight * height;
}
