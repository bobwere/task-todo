// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/injection.dart';

/* 
bootstrap the app here can do any pre app initialization required
like configuring dependency injection, log errors, setup sentry, set up 
mixpanel, setup event bus etc
*/
Future<void> bootstrap(FutureOr<Widget> Function() builder, String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  // configure dependenices
  await configureDependencies(env);

  // log errors
  FlutterError.onError = (details) {
    debugPrint('Caught error: ${details.exceptionAsString()}');
  };

  // set orientation to portrait only
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  final app = await builder();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return app;
      },
    ),
  );
}
