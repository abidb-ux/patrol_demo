import 'package:demo_app_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'report_helper.dart.dart'; // import CSV helper

void main() {
  final List<TestReport> reports = [];

  patrolTest(
    'User can login with correct credentials',
        ($) async {
      try {
        await $.pumpWidgetAndSettle(const MyApp());
        await $(#usernameField).enterText('admin');
        await $(#passwordField).enterText('1234');
        await $(#loginButton).tap();

        final msg = $(#messageText);
        await msg.waitUntilVisible();

        expect(msg.exists, equals(true));
        expect(msg.text, equals('Login Successful'));

        reports.add(TestReport(
          testName: 'User can login with correct credentials',
          status: 'PASS',
          details: 'Message shown: ${msg.text}',
        ));
      } catch (e) {
        reports.add(TestReport(
          testName: 'User can login with correct credentials',
          status: 'FAIL',
          details: e.toString(),
        ));
      }
    },
  );

  patrolTest(
    'Shows error on invalid login',
        ($) async {
      try {
        await $.pumpWidgetAndSettle(const MyApp());
        await $(#usernameField).enterText('wrong');
        await $(#passwordField).enterText('pass');
        await $(#loginButton).tap();

        final msg = $(#messageText);
        await msg.waitUntilVisible();

        expect(msg.text, equals('Invalid Credentials'));

        reports.add(TestReport(
          testName: 'Shows error on invalid login',
          status: 'PASS',
          details: 'Message shown: ${msg.text}',
        ));
      } catch (e) {
        reports.add(TestReport(
          testName: 'Shows error on invalid login',
          status: 'FAIL',
          details: e.toString(),
        ));
      }
    },
  );

  // Save CSV after all tests
  tearDownAll(() async {
    await saveCsvReport(reports);
  });
}
