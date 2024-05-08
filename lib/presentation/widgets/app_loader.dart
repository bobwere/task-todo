import 'package:flutter/material.dart';

///
Widget appLoader({required double size, Color color = Colors.white}) {
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: color,
      ),
    ),
  );
}
