import 'dart:io';

class TestReport {
  final String testName;
  final String status;
  final String details;

  TestReport({required this.testName, required this.status, required this.details});
}

Future<void> saveCsvReport(List<TestReport> reports) async {
  // Absolute path to host machine folder
  final dir = Directory('/Users/abidbashir/StudioProjects/demo_app_test/test_reports');
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final file = File('${dir.path}/patrol_report.csv');
  final sink = file.openWrite();

  // Write header
  sink.writeln('Test Name,Status,Details');

  // Write each test result
  for (var r in reports) {
    final safeDetails = r.details.replaceAll(',', ';'); // avoid breaking CSV
    sink.writeln('${r.testName},${r.status},${safeDetails}');
  }

  await sink.close();
  print('CSV report saved at ${file.path}');
}
