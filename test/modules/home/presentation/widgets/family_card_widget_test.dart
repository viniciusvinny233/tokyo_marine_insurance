import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/family_card_widget.dart';

void main() {
  testWidgets('FamilyCardWidget should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FamilyCardWidget(),
        ),
      ),
    );
    
    expect(find.byType(FamilyCardWidget), findsOneWidget);
  });
}