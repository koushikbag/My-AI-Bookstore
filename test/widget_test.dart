import 'package:flutter_test/flutter_test.dart';
import 'package:my_ai_bookstore/main.dart';

void main() {
  testWidgets('shows bookstore welcome text', (tester) async {
    await tester.pumpWidget(const BookstoreApp());

    expect(find.text('Welcome to My AI Bookstore'), findsOneWidget);
  });
}
