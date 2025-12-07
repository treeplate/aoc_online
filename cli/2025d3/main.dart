import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  int result = 0;
  for (String line in lines) {
    int subres = 0;
    int maxi = -1;
    int n = 0;
    while (n < 12) { // 12 -> 2 for part1
      int max = 0;
      int i = maxi+1;
      for (int c in line.codeUnits.sublist(maxi + 1, line.length-11+n)) { // 11 -> 1 for part1
        int v = c - 0x30;
        if (v > max) {
          max = v;
          maxi = i;
        }
        i++;
      }
      subres += max;
      subres *= 10;
      n++;
    }
    result += subres ~/ 10;
  }
  print(result);
}
