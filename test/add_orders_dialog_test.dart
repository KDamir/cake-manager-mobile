import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/pages/add_order_dialog.dart';
import 'package:mobile/src/auth.dart';
import 'package:mobile/src/auth_provider.dart';
import 'package:mockito/mockito.dart';


class MockAuth extends Mock implements BaseAuth {

}

void main() {

  Widget makeTestableWidget({Widget child, BaseAuth auth}) {
    return AuthProvider(
      auth: auth,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('should correct first screen', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    when(mockAuth.currentUser()).thenAnswer((_) => Future.value('uid'));

    AddOrderDialog dialog = new AddOrderDialog();

    await tester.pumpWidget(makeTestableWidget(child: dialog, auth: mockAuth));

    expect(find.text('Название заказа'), findsOneWidget);
    expect(find.text('Оформление'), findsOneWidget);
    expect(find.text('Описание'), findsOneWidget);
  });

  testWidgets('should correct second screen', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    when(mockAuth.currentUser()).thenAnswer((_) => Future.value('uid'));

    AddOrderDialog dialog = new AddOrderDialog();
    await tester.pumpWidget(makeTestableWidget(child: dialog, auth: mockAuth));
    await tester.tap(find.text('Далее'));
    await tester.pump();

    expect(find.text('Имя клиента'), findsOneWidget);
    expect(find.text('Контакты клиента'), findsOneWidget);
    expect(find.text('Сумма'), findsOneWidget);
  });
}