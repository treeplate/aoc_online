import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  Map<String, Set<String>> map = Map.fromEntries(
    lines.map((e) {
      String start = e.substring(0, e.indexOf(':'));
      Set<String> end = e.substring(e.indexOf(':') + 2).split(' ').toSet();
      return MapEntry(start, end);
    }),
  );
  //print(findPaths('you', 'out', map));
  print('svr-fft');
  var a = findPaths('svr', 'fft', map);
  print('fft->dac');
  var b = findPaths('fft', 'dac', map);
  print('dac->out');
  print(a * b * findPaths('dac', 'out', map));
}

int findPaths(
  String start,
  String end,
  Map<String, Set<String>> paths) {
  if (start == end) {
      return 1;
    
  }
  if (['jqr', 'yvk', 'jyv', 'aoc'].contains(start) && end == 'fft') {
    return 0;
  }
  if (['svb', 'ecy', 'you',].contains(start) && end == 'dac') {
    return 0;
  }
  int result = 0;
  for (String path in paths[start] ?? []) {
    result += findPaths(path, end, paths);
  }
  return result;
}
