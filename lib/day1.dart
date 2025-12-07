import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class Day1 extends StatefulWidget {
  @Preview()
  const Day1({super.key});

  @override
  State<Day1> createState() => _Day1State();
}

class _Day1State extends State<Day1> with SingleTickerProviderStateMixin {
  TextEditingController input = TextEditingController();
  double value = 50;
  double goal = 50;
  double speed = .1;
  int part1 = 0;
  int part2 = 0;

  @override
  void initState() {
    super.initState();
    createTicker((_) {
      setState(() {
        if ((value - goal).abs() < speed.abs()) {
          value = goal;
          if (speed != 0) {
            if (goal % 100 == 0) {
              part1++;
              part2++;
            }
          }
          speed = 0;
        } else {
          int oldValue = value.round()+1;
          value += speed;
          if (speed.abs() < 1) {
            if (value % 100 < speed.abs() && (value - goal).abs() > speed.abs()) {
              part2++;
            }
          } else {
            while (speed.sign == 1 ? oldValue < value : oldValue > value) {
              if (oldValue % 100 == 0) {
                part2++;
              }
              oldValue++;
            }
          }
        }
      });
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onSubmitted: (value) {
            int num = int.parse(value.substring(1));
            if (value.startsWith('R')) {
              goal += num.toDouble();
              speed = num / 100;
            }
            if (value.startsWith('L')) {
              goal -= num.toDouble();
              speed = -num / 100;
            }
          },
        ),
        Expanded(
          child: Row(
            children: [
              SafeCodeWidget(value),
              Text(
                'Times landed on 0 (part 1): $part1\nTimes passed 0 (part 2): $part2',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SafeCodeWidget extends LeafRenderObjectWidget {
  const SafeCodeWidget(this.state, {super.key});

  final double state;

  @override
  RenderBox createRenderObject(BuildContext context) {
    return SafeCodeRenderBox(state);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant SafeCodeRenderBox renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    renderObject.state = state;
  }
}

class SafeCodeRenderBox extends RenderBox {
  SafeCodeRenderBox(this.state);
  double state;

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    return Size.square(constraints.biggest.shortestSide);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.drawCircle(
      size.center(offset),
      size.longestSide / 2,
      Paint()..color = Colors.white,
    );
    context.canvas.drawVertices(
      Vertices(VertexMode.triangles, [
        size.topCenter(offset) + Offset(size.width / 20, 0),
        size.topCenter(offset) - Offset(size.width / 20, 0),
        size.topCenter(offset) + Offset(0, size.width / 20),
      ]),
      BlendMode.dst,
      Paint()..color = Colors.grey,
    );
    int i = 0;
    int tickSize = 1;
    context.canvas.translate(
      offset.dx + size.width / 2,
      offset.dy + size.height / 2,
    );
    context.canvas.rotate(-2 * pi * state / 100);
    context.canvas.translate(
      -offset.dx - size.width / 2,
      -offset.dy - size.height / 2,
    );
    while (i < 100) {
      context.canvas.drawLine(
        size.topCenter(offset),
        size.topCenter(offset) + Offset(0, size.height / 10),
        Paint()..color = Colors.black,
      );
      ParagraphBuilder builder = ParagraphBuilder(ParagraphStyle());
      builder.addText('$i');
      context.canvas.drawParagraph(
        builder.build()..layout(ParagraphConstraints(width: 20)),
        size.topCenter(offset) + Offset(-'$i'.length * 5, size.height / 10),
      );
      context.canvas.translate(
        offset.dx + size.width / 2,
        offset.dy + size.height / 2,
      );
      context.canvas.rotate(2 * pi * tickSize / 100);
      context.canvas.translate(
        -offset.dx - size.width / 2,
        -offset.dy - size.height / 2,
      );
      i += tickSize;
    }
    context.canvas.restore();
  }
}
