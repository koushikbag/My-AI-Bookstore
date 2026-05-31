import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_ai_bookstore/main.dart';

void main() {
  testWidgets('app starts with splash screen', (tester) async {
    await tester.pumpWidget(const BookstoreApp());

    // Verify splash screen is shown initially
    expect(find.byIcon(Icons.book), findsOneWidget);
    expect(find.text('My AI Bookstore'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
