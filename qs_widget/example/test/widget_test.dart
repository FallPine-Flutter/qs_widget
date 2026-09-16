import 'package:flutter_test/flutter_test.dart';
import 'package:qs_widget_example/main.dart';

void main() {
  testWidgets('shows qs_widget example', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('qs_widget'), findsOneWidget);
  });
}
