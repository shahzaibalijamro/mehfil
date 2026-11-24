import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  testWidgets('App loads Host Login view smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('HOST PANEL'), findsOneWidget);
    expect(find.text('Log in'), findsWidgets);
  });
}
