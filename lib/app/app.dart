// ignore_for_file: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/application/main_controller.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/presentation/router/router.dart';
import 'package:todo_app/shared/constant/app_strings.dart';
import 'package:activity/activity.dart';
import 'package:todo_app/shared/util/cache_image_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    cacheImages(context);
    //
    return Activity(
      getIt<MainController>(),
      onActivityStateChanged: () =>
          DateTime.now().millisecondsSinceEpoch.toString(),
      child: MaterialApp.router(
        title: appName,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        routerConfig: goRouter,
        theme: ThemeData(fontFamily: 'Gogh'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
