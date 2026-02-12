import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late List<Offset> points;
Rect? bestRect;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  points = (await rootBundle.loadString('i/input.txt')).split('\n').map((e) {
    List<int> nums = e.split(',').map((e) => int.parse(e)).toList();
    return Offset(nums.first.toDouble(), nums.last.toDouble());
  }).toList();
  Path path = Path();
  for (Offset point in points) {
    path.lineTo(point.dx, point.dy);
  }
  int maxSize = 0;
  for (Offset square in points) {
    for (Offset square2 in points) {
      if (square.dy < 50_000 != square2.dy < 50_000) continue;
      if (!path.contains(Offset(square2.dx, square.dy))) continue;
      if (!path.contains(Offset(square.dx, square2.dy))) continue;
      var b =
          ((square2.dx - square.dx).abs() + 1) *
          ((square2.dy - square.dy).abs() + 1);
          //if (b != 1554318940) {
      maxSize = max(maxSize, b).toInt();
          //}
      if (b == maxSize) {
        bestRect = Rect.fromLTRB(square.dx, square.dy, square2.dx, square2.dy);
      }
    }
  }
  print(maxSize);
  runApp(CustomPaint(painter: CP()));
}

class CP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoints(
      PointMode.polygon,
      points
          .map(
            (e) => Offset(
              e.dx * size.width / 100_000,
              e.dy * size.height / 100_000,
            ),
          )
          .toList(),
      Paint()..color = Colors.green,
    );
    canvas.drawRect(
      Rect.fromLTRB(
        bestRect!.left * size.width / 100_000,
        bestRect!.top * size.height / 100_000,
        bestRect!.right * size.width / 100_000,
        bestRect!.bottom * size.height / 100_000,
      ),
      Paint()..color = Colors.red.withAlpha(100),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
