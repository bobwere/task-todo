import 'package:flutter/material.dart';
import 'package:todo_app/shared/constant/app_strings.dart';

///
class AppTextStyles {
  ///
  TextStyle displayLarge() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w900,
        fontSize: 34,
        decoration: TextDecoration.none,
        letterSpacing: 0.1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle displayMedium() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        decoration: TextDecoration.none,
        letterSpacing: -0.5,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle displaySmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        decoration: TextDecoration.none,
        letterSpacing: 0,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle headlineLarge() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 24,
        decoration: TextDecoration.none,
        letterSpacing: 0.15,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle headlineMedium() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.25,
        decoration: TextDecoration.none,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle headlineSmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        decoration: TextDecoration.none,
        letterSpacing: 0,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle titleLarge() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        decoration: TextDecoration.none,
        letterSpacing: 0.5,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle titleMedium() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        decoration: TextDecoration.none,
        letterSpacing: 0.5,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle titleSmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        decoration: TextDecoration.none,
        letterSpacing: 0.5,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle bodyLarge() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle bodyMedium() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle bodySmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle bodyVerySmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 10,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle bodyExtraSmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 8,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle labelLarge() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle labelMedium() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle labelSmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 10,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle labelVerySmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 8,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );

  ///
  TextStyle labelExtraSmall() => const TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 6,
        decoration: TextDecoration.none,
        letterSpacing: 1,
        leadingDistribution: TextLeadingDistribution.even,
      );
}
