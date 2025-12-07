import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  int result = 0;
  int code = 50;
  for (String line in lines) {
    int goal = 0;
    if (line.startsWith('R')) {
      goal = int.parse(line.substring(1));
    }
    if (line.startsWith('L')) {
      goal = -int.parse(line.substring(1));
    }

    while (goal != 0) {
      code += goal.sign;
      goal -= goal.sign;
      code = code % 100;
      if (code == 0) { // for part1, move this to after the while loop
        result++;
      }
    }
  }
  print(result);
}

