import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/shared/constant/app_assets.dart';

ScalableImageCache svgCache = ScalableImageCache(size: 50);

final svgPaths = <String>[
  businessEarningActiveSvg,
  businessEarningInActiveSvg,
  businessManageActiveSvg,
  businessManageInActiveSvg,
];

void cacheImages(BuildContext context) {
  final cache = getIt<ScalableImageCache>();

  for (final path in svgPaths) {
    cache.addReferenceV2(
      ScalableImageSource.fromSI(
        DefaultAssetBundle.of(context),
        path,
      ),
    );
  }
}
