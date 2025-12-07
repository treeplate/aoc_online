import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  String ops = lines.last;
  List<String> nums = lines.sublist(0, lines.length - 1);
  int i = 0;
  int result = 0;
  while (i < nums.first.length) {
    int x = i;
    int y = 0;
    bool numberSeen = false;
    List<int> newNums = [0];
    while (true) {
      String value = nums[y][x];
      if (value != ' ') {
        numberSeen = true;
        newNums[x - i] *= 10;
        newNums[x - i] += int.parse(value);
      }
      y++;
      if (y == nums.length) {
        print('${newNums[x - i]}');
        y = 0;
        x++;
        if (numberSeen && x < nums[y].length) {
          newNums.add(0);
        } else {
          if (!numberSeen) {
            newNums.removeLast();
          }
          break;
        }
        numberSeen = false;
      }
    }
    print('${ops[i]}: $newNums');
    result += ops[i] == '+'
        ? newNums.fold(0, (a, b) => a + b)
        : newNums.fold(1, (a, b) => a * b);
    i = x;
  }
  print(result);
}
