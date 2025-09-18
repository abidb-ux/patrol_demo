import 'package:demo_app_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginPage widget tests', () {
    testWidgets('renders username, password, login button, and message text',
            (WidgetTester tester) async {
          // Pump the LoginPage into the widget tree
          await tester.pumpWidget(const MaterialApp(home: MyApp()));

          // Verify widgets are present
          expect(find.byKey(const Key('usernameField')), findsOneWidget);
          expect(find.byKey(const Key('passwordField')), findsOneWidget);
          expect(find.byKey(const Key('loginButton')), findsOneWidget);
          expect(find.byKey(const Key('messageText')), findsOneWidget);
        });

    testWidgets('shows "Login Successful" for correct credentials',
            (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: LoginPage()));

          // Enter valid username and password
          await tester.enterText(
              find.byKey(const Key('usernameField')), 'admin');
          await tester.enterText(
              find.byKey(const Key('passwordField')), '1234');

          // Tap login
          await tester.tap(find.byKey(const Key('loginButton')));
          await tester.pump(); // rebuild after setState

          // Verify success message
          expect(find.text('Login Successful'), findsOneWidget);
        });

    testWidgets('shows "Invalid Credentials" for wrong credentials',
            (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: LoginPage()));

          // Enter wrong username and password
          await tester.enterText(
              find.byKey(const Key('usernameField')), 'user');
          await tester.enterText(
              find.byKey(const Key('passwordField')), 'wrongpass');

          // Tap login
          await tester.tap(find.byKey(const Key('loginButton')));
          await tester.pump(); // rebuild after setState

          // Verify error message
          expect(find.text('Invalid Credentials'), findsOneWidget);
        });
  });
}
