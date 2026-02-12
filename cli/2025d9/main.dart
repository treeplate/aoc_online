import 'dart:io';
import 'dart:math';

void main() {
  List<(int, int)> lines = File('input').readAsLinesSync().map((e) {
    List<int> nums = e.split(',').map((e) => int.parse(e)).toList();
    return (nums.first, nums.last);
  }).toList();
  int maxSize = 0;
  for ((int, int) square in lines) {
    for ((int, int) square2 in lines) {
      if (square.$2 < 50_000 != square2.$2 < 50_000) continue;
      var b =
          ((square2.$1 - square.$1).abs() + 1) *
          ((square2.$2 - square.$2).abs() + 1);
      maxSize = max(maxSize, b);
      if (b == maxSize) {
        print('$square..$square2');
      }
    }
  }
  print(maxSize);
}
