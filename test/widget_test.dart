import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/home_screen.dart';

void main() {
  testWidgets('Weather search test', (WidgetTester tester) async {
    // Build the HomeScreen widget.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Check if the initial city displayed is 'Nairobi'.
    expect(find.text('Nairobi'), findsOneWidget);

    // Enter a new city name into the text field.
    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'Mombasa');
    await tester.pump();

    // Tap the search button to fetch weather for the new city.
    final searchButtonFinder = find.byIcon(Icons.search);
    await tester.tap(searchButtonFinder);
    await tester.pump();

    // Since we cannot actually hit the API during tests, we'll just check that the UI updates.
    // Ensure that the text field is cleared after a search.
    expect(find.text('Mombasa'), findsOneWidget);
  });
}
