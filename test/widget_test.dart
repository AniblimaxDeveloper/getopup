import 'package:flutter_test/flutter_test.dart';
import 'package:getopup/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('GeTopUp'), findsOneWidget);
  });
}
