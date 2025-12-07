import 'package:flutter/material.dart';

const double cellsize = 75;

class GridDrawer extends StatelessWidget {
  const GridDrawer(this.grid, this.width, this.onTap, {super.key});
  final List<GridCell> grid;
  final int width;
  final void Function(int, int) onTap;
  int get height => grid.length ~/ width;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: GestureDetector(
        onTapDown: (details) {
          onTap(
            details.localPosition.dx ~/ cellsize,
            details.localPosition.dy ~/ cellsize,
          );
        },
        child: SizedBox(
          width: cellsize * width,
          height: cellsize * height,
          child: CustomPaint(painter: GridPainter(width, height, grid)),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  GridPainter(this.width, this.height, this.grid);
  final int width;
  final int height;
  final List<GridCell> grid;
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  @override
  void paint(Canvas canvas, Size size) {
    Size cellSize = Size(cellsize, cellsize);
    for (int y = 0; y < height; y += 1) {
      for (int x = 0; x < width; x += 1) {
        grid[x + (y * width)].paint(
          canvas,
          cellSize,
          Offset(x * cellsize, y * cellsize),
        );
      }
    }
  }
}

abstract class GridCell {
  void paint(Canvas canvas, Size size, Offset offset);
}
