import 'package:flutter/material.dart';

class Day3 extends StatefulWidget {
  const Day3({super.key});

  @override
  State<Day3> createState() => _Day3State();
}

// potential improvements: show each digit as a battery and light up the ones we're using

class _Day3State extends State<Day3> {
  int part1 = 0;
  int part2 = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            onSubmitted: (value) {
              int subres = 0;
              int maxi = -1;
              int n = 0;
              while (n < 2) {
                int max = 0;
                int i = maxi + 1;
                for (int c in value.codeUnits.sublist(
                  maxi + 1,
                  value.length - 1 + n,
                )) {
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
              setState(() {
                part1 = subres ~/ 10;
              });
              subres = 0;
              maxi = -1;
              n = 0;
              while (n < 12) {
                int max = 0;
                int i = maxi + 1;
                for (int c in value.codeUnits.sublist(
                  maxi + 1,
                  value.length - 11 + n,
                )) {
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
              setState(() {
                part2 = subres ~/ 10;
              });
            },
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        Text('Part 1 joltage: $part1'),
        Text('Part 2 joltage: $part2'),
      ],
    );
  }
}
