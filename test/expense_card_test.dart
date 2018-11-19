import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/models/expense_card.dart';


void main() {

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
        home: child,
    );
  }

  testWidgets('should correct filled text', (WidgetTester tester) async {

    ExpenseCard card = ExpenseCard(
      name: 'мука',
      type: 'type',
      value: 300.0,
    );

    await tester.pumpWidget(makeTestableWidget(child: card));

    expect(find.text('type'), findsOneWidget);
    expect(find.text('мука 300.0 тг.'), findsOneWidget);
  });

}