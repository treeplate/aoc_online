import 'dart:io';
import 'dart:math';

void main() {
  List<(int, int, int)> coords = File('input').readAsLinesSync().map((e) {
    List<int> parts = e.split(',').map((e) => int.parse(e)).toList();
    return (parts[0], parts[1], parts[2]);
  }).toList();
  Set<((int, int, int), (int, int, int))> pairingsSet = {};
  for ((int, int, int) coord in coords) {
    for ((int, int, int) coord2 in coords) {
      if (coord2 == coord) continue;
      if (!pairingsSet.contains((coord2, coord))) {
        pairingsSet.add((coord, coord2));
      }
    }
  }
  print('sorting pairings');
  List<((int, int, int), (int, int, int))> pairings = pairingsSet.toList();
  print('toListed');
  pairings.sort(
    (a, b) => getDistance(a.$1, a.$2).abs().compareTo(getDistance(b.$1, b.$2)),
  );
  Set<Set<(int, int, int)>> circuits = {};
  int i = 0;
  print('connecting...');
  for (((int, int, int), (int, int, int)) pairing in pairings) { // .take(1000) for part1
    if (circuits.any((e) => e.contains(pairing.$1))) {
      if (circuits.any((e) => e.contains(pairing.$2))) {
        Set<(int, int, int)> set2 = circuits.singleWhere(
          (e) => e.contains(pairing.$2),
        );
        if (set2.contains(pairing.$1)) {
          continue;
        }
        circuits
            .singleWhere((e) => e.contains(pairing.$1))
            .addAll(circuits.singleWhere((e) => e.contains(pairing.$2)));
        circuits.remove(set2);
      } else {
        circuits.singleWhere((e) => e.contains(pairing.$1)).add(pairing.$2);
      }
    } else if (circuits.any((e) => e.contains(pairing.$2))) {
      circuits.singleWhere((e) => e.contains(pairing.$2)).add(pairing.$1);
    } else {
      circuits.add({pairing.$1, pairing.$2});
    }
    if (circuits.length==1 && circuits.single.length == coords.length) { // don't do this for part 1
      print('$pairing: ${pairing.$1.$1*pairing.$2.$1}');
      exit(0);
    }
  }
  print('final sort');
  List<int> sizes = (circuits.map((e) => e.length).toList()..sort()).reversed
      .toList();
  print('${sizes[1] * sizes[0] * sizes[2]}');
}

double getDistance((int, int, int) a, (int, int, int) b) => sqrt(
  (a.$1 - b.$1).abs() * (a.$1 - b.$1).abs() +
      (a.$2 - b.$2).abs() * (a.$2 - b.$2).abs() +
      (a.$3 - b.$3).abs() * (a.$3 - b.$3).abs(),
);
