import 'dart:io';

import 'package:leitor_licov/reader_licov.dart' as licov;
import 'package:leitor_licov/line_report.dart';
import 'package:test/test.dart';

void main() {
  final filePath = "./coverage/lcov.info";
  late File file;
  late List<String> content;
  late List<LineReport> lineReports;

  setUpAll(() {
    file = File(filePath);
    content = file.readAsLinesSync();

    lineReports = licov.contentLineReport(content);
  });

  test('Should obtain the total percentage of coverage', () {
    final result = licov.coverage(filePath);
    final castLineReports = lineReports.map((report) {
      return '''SF: ${report.sourceFile} 
              \n LF: ${report.lineFound} 
              \n LH: ${report.lineHit}
      ''';
    }).toList();

    final getStatusMain = licov.main(castLineReports);

    expect(getStatusMain, 0);
    expect(result, "100%");
  });

  test("Should check the equality of the list", () {
    final reports = licov.contentLineReport(content);
    expect(reports, equals(lineReports));
  });

  test("Should check the percentage return as a future", () {
    final percentage = licov.getPercentageFromFuture();

    expect(percentage, completes);
    expect(percentage, completion(equals("100%")));
  });
  
  test("Should check the percentage return as a Stream", () {
    final percentage = licov.getPercentageFromStream();

    expect(percentage, emitsInOrder(["100%", "completed"]));
  });
}
