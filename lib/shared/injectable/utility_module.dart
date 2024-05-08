import 'package:injectable/injectable.dart';
import 'package:jovial_svg/jovial_svg.dart';

///
@module
abstract class UtilityModule {
  @lazySingleton
  ScalableImageCache get scalableImageCache => ScalableImageCache(size: 200);
}
