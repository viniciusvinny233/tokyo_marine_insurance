import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/contracts_card_widget.dart';

void main() {
  testWidgets('ContractsCardWidget should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContractsCardWidget(),
        ),
      ),
    );

    expect(find.byType(ContractsCardWidget), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_dissatisfied_rounded), findsOneWidget);
  });
}