import 'package:todo_app/shared/constant/app_assets.dart';

enum HomeBottomNavigationItem {
  ///
  home(0, 'Home', businessEarningActiveSvg, businessEarningInActiveSvg),

  ///
  completed(
    1,
    'Completed',
    businessManageActiveSvg,
    businessManageInActiveSvg,
  );

  const HomeBottomNavigationItem(
    this.idx,
    this.name,
    this.svgActivePath,
    this.svgInactivePath,
  );

  ///
  final int idx;

  ///
  final String name;

  ///
  final String svgActivePath;

  final String svgInactivePath;
}
