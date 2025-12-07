import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  Map<int, int> beams = {lines.first.indexOf('S'): 1};
  int result = 0;
  for (String line in lines) {
    for (MapEntry<int, int> beam in beams.entries.toList()) {
      if (line[beam.key] == '^') {
        beams.remove(beam.key);
        beams[beam.key-1] = (beams[beam.key-1] ?? 0) + beam.value;
        beams[beam.key+1] = (beams[beam.key+1] ?? 0) + beam.value;
        result += 1;
      }
    }
  }
  print('part 1: $result');
  print('part 2: ${beams.values.fold<int>(0, (a,b)=>a+b)}');
}
