import 'dart:convert';

void main() {
  List<Map<String, dynamic>> students = [
    {"name": "Alice", "scores": [85, 90, 78]},
    {"name": "Bob", "scores": [88, 76, 95]},
    {"name": "Charlie", "scores": [90, 92, 85]},
  ];

  Map<String, double> averages = {};

  for (var student in students) {
    String name = student['name'];
    List<int> scores = List<int>.from(student['scores']);
    double avg = scores.reduce((a, b) => a + b) / scores.length;
    averages[name] = double.parse(avg.toStringAsFixed(2));
  }

  var sortMap = Map.fromEntries(
    averages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)),
  );

  print("{");
  sortMap.forEach((key, value) {
    String line = '  "$key": $value';
    if (key != sortMap.keys.last) {
      line += ",";
    }
    print(line);
  });
  print("}");
}
