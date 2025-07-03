import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double hp(double percent) => height * (percent / 100);

  double wp(double percent) => width * (percent / 100);

  bool get isDesktop => width > 800;
}
