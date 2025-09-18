import 'package:demo_app_test/main.dart' as app;
import 'package:patrol/patrol.dart';
import 'package:flutter/material.dart';

void main() {
  patrolTest('Counter increments when FAB is tapped', ($) async {
    // Launch app
    app.main();
    await $.pumpAndSettle();

    // Verify initial counter
    final zero = await $('0').exists;
    if (!zero) throw Exception('Counter 0 not found');

    // Tap FAB
    await $(FloatingActionButton).tap();

    // Verify counter incremented
    final one = await $('1').exists;
    if (!one) throw Exception('Counter 1 not found');

    // Tap FAB again
    await $(FloatingActionButton).tap();

    // Verify counter incremented to 2
    final two = await $('2').exists;
    if (!two) throw Exception('Counter 2 not found');
  });
}
