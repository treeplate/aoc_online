import 'package:flutter/scheduler.dart';

import 'grid.dart';
import 'package:flutter/material.dart';

class Day4 extends StatefulWidget {
  const Day4({super.key});

  @override
  State<Day4> createState() => _Day4State();
}

class _Day4State extends State<Day4> with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  int width = 10;
  int height = 10;
  List<GridCell> grid = List.filled(100, EmptyCell());
  bool running = false;
  @override
  void initState() {
    ticker = createTicker(tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void tick(Duration duration) {
    if (duration.inMilliseconds % 1000 < 20 && running) {
      int lookup(int x, int y) {
        if (x >= width || x < 0 || y >= height || y < 0) {
          return 0;
        }
        return grid[x + y * width] is ToiletPaperCell ? 1 : 0;
      }

      int x = 0;
      int y = 0;
      List<(int, int)> removed = [];
      while (y < height) {
        if (grid[x + y * width] is ToiletPaperCell) {
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
          }
        }
        x++;
        if (x >= width) {
          x = 0;
          y++;
        }
      }
      setState(() {
        for ((int, int) p in removed) {
          grid[p.$1 + p.$2 * width] = EmptyCell();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridDrawer(grid, 10, (x, y) {
          setState(() {
            if (grid[x + y * width] is EmptyCell) {
              grid[x + y * width] = ToiletPaperCell();
            } else {
              grid[x + y * width] = EmptyCell();
            }
          });
        }),
        Row(
          children: [
            Text('Run forklifts'),
            Checkbox(
              value: running,
              onChanged: (value) {
                setState(() {
                  running = value!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyCell extends GridCell {
  @override
  void paint(Canvas canvas, Size size, Offset offset) {}
}

class ToiletPaperCell extends GridCell {
  ToiletPaperCell();
  @override
  void paint(Canvas canvas, Size size, Offset offset) {
    canvas.drawCircle(
      size.center(offset),
      size.width / 2,
      Paint()..color = Colors.white,
    );
  }
}
