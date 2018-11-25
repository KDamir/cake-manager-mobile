import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/auth.dart';
import 'package:mobile/src/auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile/src/pages/add_expense_dialog.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {

  Widget makeTestableWidget({Widget child, BaseAuth auth}) {
    return AuthProvider(
      auth: auth,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('should correct dialog shows', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    when(mockAuth.currentUser()).thenAnswer((_) => Future.value('uid'));

    AddExpenseDialog dialog = new AddExpenseDialog();

    await tester.pumpWidget(makeTestableWidget(child: dialog, auth: mockAuth));

    expect(find.text('Название расхода'), findsOneWidget);
    expect(find.text('Тип'), findsOneWidget);
    expect(find.text('Сумма'), findsOneWidget);
  });

}