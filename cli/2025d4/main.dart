import 'dart:io';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  int width = lines.first.length;
  int height = lines.length;
  List<String> grid = lines.expand((e) => e.split('')).toList();
  int lookup(int x, int y) {
    if (x >= width || x < 0 || y >= height || y < 0) {
      return 0;
    }
    return grid[x + y * width] == '@' ? 1 : 0;
  }

  int result = 0;
  int oresult = 0;
  do {
    oresult = result;
    int x = 0;
    int y = 0;
    List<(int, int)> removed = [];
    while (y < height) {
      if (grid[x + y * width] == '@') {
        int count = 0;
        count += lookup(x, y + 1);
        count += lookup(x, y - 1);
        count += lookup(x + 1, y + 1);
        count += lookup(x + 1, y - 1);
        count += lookup(x - 1, y + 1);
        count += lookup(x - 1, y - 1);
        count += lookup(x + 1, y);
        count += lookup(x - 1, y);
        if (count < 4) {
          removed.add((x, y));
          result++;
        }
      }
      x++;
      if (x >= width) {
        x = 0;
        y++;
      }
    }
    for ((int,int) p in removed) {
      grid[p.$1+p.$2*width] = ' ';
    }
  } while (oresult != result); // change to while(false) for part1
  print(result);
}
