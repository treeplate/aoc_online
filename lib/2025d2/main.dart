import 'dart:io';

void main() {
  String line = File('input').readAsStringSync();
  int result = 0;
  List<String> parts = line.split(',');
  for (String part in parts) {
    int i = part.indexOf('-');
    int left = int.parse(part.substring(0, i));
    int right = int.parse(part.substring(i + 1));
    while (left <= right) {
      int l = left.toString().length ~/ 2;
      mid:
      while (l >= 1) { // if part1, only do the first iteration of this loop
        if (left.toString().length % l != 0) {
          l--;
          continue;
        }
        int i = l;
        String result2 = left.toString().substring(0, l);
        while (i < left.toString().length) {
          if (result2 != left.toString().substring(i, i + l)) {
            l--;
            continue mid;
          }
          i+=l;
        }
        result += left;
        break mid;
      }
      left++;
    }
  }

  print(result);
}
