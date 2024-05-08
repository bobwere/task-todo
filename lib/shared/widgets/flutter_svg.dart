import 'package:flutter/widgets.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:todo_app/injection.dart';

class FlutterSvg extends StatefulWidget {
  const FlutterSvg({
    required this.height,
    required this.width,
    required this.asset,
    required this.scale,
    super.key,
  });

  final double height;
  final double width;
  final String asset;
  final double scale;

  @override
  State<FlutterSvg> createState() => _FlutterSvgState();
}

class _FlutterSvgState extends State<FlutterSvg> {
  @override
  Widget build(BuildContext context) {
    final cache = getIt<ScalableImageCache>();

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ScalableImageWidget.fromSISource(
        cache: cache,
        scale: widget.scale,
        si: ScalableImageSource.fromSI(
          DefaultAssetBundle.of(context),
          widget.asset,
        ),
      ),
    );
  }
}
