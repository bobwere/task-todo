import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/shared/constant/enums.dart';
import 'package:todo_app/shared/util/text_util.dart';
import 'package:todo_app/shared/util/ui_util.dart';
import 'package:todo_app/shared/widgets/flutter_svg.dart';

class HomeScaffoldWithNestedNavigation extends StatefulWidget {
  const HomeScaffoldWithNestedNavigation({
    required this.navigationShell,
    Key? key,
  }) : super(
          key: key ?? const ValueKey('HomeScaffoldWithNestedNavigation'),
        );
  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScaffoldWithNestedNavigation> createState() =>
      _HomeScaffoldWithNestedNavigationState();
}

class _HomeScaffoldWithNestedNavigationState
    extends State<HomeScaffoldWithNestedNavigation> {
  int pageIndex = 0;

  @override
  void initState() {
    pageIndex = widget.navigationShell.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(HomeScaffoldWithNestedNavigation oldWidget) {
    if (oldWidget.navigationShell != widget.navigationShell) {
      pageIndex = widget.navigationShell.currentIndex;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);

    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: Container(
        height: ui.scaleWidthFactor(ui.spacing.spacing48),
        color: ui.colors.primary,
        child: Padding(
          padding: EdgeInsets.only(top: ui.scaleHeightFactor(2)),
          child: Row(
            children: [
              ...<HomeBottomNavigationItem>[
                HomeBottomNavigationItem.home,
                HomeBottomNavigationItem.completed,
              ].map(
                (item) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _goBranch(item.idx);
                    setState(() {
                      pageIndex = item.idx;
                    });
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (pageIndex == item.idx)
                          FlutterSvg(
                            asset: item.svgActivePath,
                            height: ui.scaleHeightFactor(20),
                            width: ui.scaleWidthFactor(20),
                            scale: ui.scale,
                          ),
                        if (pageIndex != item.idx)
                          FlutterSvg(
                            asset: item.svgInactivePath,
                            height: ui.scaleHeightFactor(20),
                            width: ui.scaleWidthFactor(20),
                            scale: ui.scale,
                          ),
                        spacerVertical(
                          ui.scaleHeightFactor(ui.spacing.spacing4),
                        ),
                        Text(
                          item.name,
                          style: ui.textStyle.displayLarge().copyWith(
                                fontSize: 8,
                                color: pageIndex == item.idx
                                    ? ui.colors.activeColor
                                    : ui.colors.background.withOpacity(0.6),
                              ),
                          textScaler: TextScaler.linear(ui.textScaleFactor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
