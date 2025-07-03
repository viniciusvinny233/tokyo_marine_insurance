import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/core/utils/responsive_helper.dart';

void main() {
  testWidgets('ResponsiveExtension should provide correct height and width', (WidgetTester tester) async {
    late double height;
    late double width;
    late double heightPercent;
    late double widthPercent;
    late bool isDesktop;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            height = context.height;
            width = context.width;
            heightPercent = context.hp(10);
            widthPercent = context.wp(10);
            isDesktop = context.isDesktop;
            return const Scaffold();
          },
        ),
      ),
    );

    expect(height, equals(600.0)); 
    expect(width, equals(800.0));
    expect(heightPercent, equals(60.0)); 
    expect(widthPercent, equals(80.0)); 
    expect(isDesktop, equals(false)); 
  });

  testWidgets('isDesktop should return true when width > 800', (WidgetTester tester) async {
    late bool isDesktop;

    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            isDesktop = context.isDesktop;
            return const Scaffold();
          },
        ),
      ),
    );

    expect(isDesktop, equals(true));

    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}