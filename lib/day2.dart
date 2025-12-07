import 'package:flutter/material.dart';

class Day2 extends StatefulWidget {
  const Day2({super.key});

  @override
  State<Day2> createState() => _Day2State();
}

class _Day2State extends State<Day2> {
  Set<int> part1 = {};
  Set<int> part2 = {};
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: SizedBox(
            width: 200,
            child: TextField(
              onSubmitted: (value) {
                part1.clear();
                part2.clear();
                int i = value.indexOf('-');
                int left = int.parse(value.substring(0, i));
                int right = int.parse(value.substring(i + 1));
                while (left <= right) {
                  int l = left.toString().length ~/ 2;
                  int ol = l;
                  mid:
                  while (l >= 1) {
                    // if part1, only do the first iteration of this loop
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
                      i += l;
                    }
                    setState(() {
                    if (ol == l && left.toString().length.isEven) {
                      part1.add(left);
                    } else {
                      part2.add(left);
                    }
                      
                    });
                    break mid;
                  }
                  left++;
                }
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Center(child: Text('Part 1 invalid IDs:')),
        ...part1.map((e) => Center(child: Text(e.toString()))),
        Center(child: Text('Part 2 invalid IDs:')),
        ...part2.map((e) => Center(child: Text(e.toString()))),
      ],
    );
  }
}
