import 'dart:io';
import 'dart:math';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  List<String> ranges = lines.sublist(0, lines.indexOf(''));
  Set<(int, int)> newRanges = {};
  // for part2:
  for (String range in ranges) {
    int l = int.parse(range.substring(0, range.indexOf('-')));
    int r = int.parse(range.substring(range.indexOf('-') + 1));
    Set<(int, int)> tbr = {};
    (int, int) newR = (l, r);
    for ((int, int) r2 in newRanges) {
      if (newR.$2 >= r2.$1 && newR.$1 <= r2.$2) {
        tbr.add(r2);
        newR = (min(r2.$1, newR.$1), max(r2.$2, newR.$2));
      }
    }
    newRanges.removeAll(tbr);
    newRanges.add(newR);
  }
  print(newRanges.fold<int>(0, (a, b) => a + b.$2 - b.$1 + 1));
  // for part1:
  List<int> nums = lines
      .sublist(lines.indexOf('') + 1)
      .map((e) => int.parse(e))
      .toList();
  int count = 0;
  outer:
  for (int n in nums) {
    for (String range in ranges) {
      if (int.parse(range.substring(0, range.indexOf('-'))) < n &&
          int.parse(range.substring(range.indexOf('-') + 1)) > n) {
        count++;
        continue outer;
      }
    }
  }
  print(count);
}
