import 'package:flutter_test/flutter_test.dart';
import 'package:getopup/main.dart';

void main() {
  testWidgets('App renders', (tester) async {
    await tester.pumpWidget(const GeTopUpApp());
    expect(find.text('GeTopUp'), findsOneWidget);
  });
}
