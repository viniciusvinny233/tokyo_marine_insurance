import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/insurance_grid_widget.dart';

void main() {
  testWidgets('InsuranceGridWidget should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InsuranceGridWidget(),
        ),
      ),
    );

    expect(find.byType(InsuranceGridWidget), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    
    expect(find.byIcon(Icons.directions_car_outlined), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    
    expect(find.text('Automóvel'), findsOneWidget);
  });
}