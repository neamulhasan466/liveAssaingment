import 'dart:io';
import 'dart:convert';

void main() {
  print("Paste your JSON input and press Jadui :");

  List<String> lines = [];
  while (true) {
    String? line = stdin.readLineSync();
    if (line == null || line.trim().isEmpty) {
      break;
    }
    lines.add(line);
  }

  String input = lines.join('\n').trim();

  if (input.endsWith(';')) {
    input = input.substring(0, input.length - 1).trim();
  }

  try {
    List<dynamic> students = jsonDecode(input);

    Map<String, double> averages = {};
    for (var student in students) {
      String name = student['name'];
      List<dynamic> scores = student['scores'];
      double avg = scores.reduce((a, b) => a + b) / scores.length;
      averages[name] = double.parse(avg.toStringAsFixed(2));
    }

    var sortedMap = Map.fromEntries(
      averages.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    print("{");
    sortedMap.forEach((key, value) {
      String line = '  "$key": $value';
      if (key != sortedMap.keys.last) line += ",";
      print(line);
    });
    print("}");
  } catch (e) {
    print("JSON format error: $e");
  }
}
