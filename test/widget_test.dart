import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/pages/order_detail.dart';
import 'package:mobile/src/cake_order_model.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {

    await tester.pumpWidget(const Text('foo', textDirection: TextDirection.ltr));
    expect(find.text('foo'), findsOneWidget);

  });
}