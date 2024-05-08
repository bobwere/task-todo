import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/router/routes.dart';
import 'package:todo_app/shared/util/ui_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // wait 2 seconds and navigate to home route
    Future.delayed(const Duration(seconds: 1), () {
      context.goNamed(homeRoute);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ui = UiUtil(context);
    return Scaffold(
      body: Center(
        child: Text(
          'Task App',
          style: ui.textStyle.displayMedium(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
