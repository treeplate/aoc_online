import 'dart:io';
import 'dart:math';

void main() {
  List<String> lines = File('input').readAsLinesSync();
  int result = 0;
  int i = 1;
  for (String line in lines) {
    List<String> parts = line.split(' ');
    String goalStr = parts[0];
    int oldGoal = goalStr
        .substring(1, goalStr.length - 1)
        .split('')
        .reversed
        .map((e) => e == '#' ? 1 : 0)
        .fold(0, (a, b) => a * 2 + b);
    List<int> goal = parts.last
        .substring(1, parts.last.length - 1)
        .split(',')
        .map((e) => int.parse(e))
        .toList();
    Iterable<List<int>> switches = parts.sublist(1, parts.length - 1).map((e) {
      return e
          .substring(1, e.length - 1)
          .split(',')
          .fold(0, (a, b) => a + (1 << int.parse(b)))
          .toRadixString(2)
          .padLeft(goal.length, '0')
          .split('')
          .reversed
          .map((e) => e == '1' ? 1 : 0)
          .toList();
    });
    int steps = goal.fold(0, (a,b) => max(a,b));
    while (true) {
      print('trying $steps steps');
      if (recurse2(steps, switches, goal, List.filled(goal.length, 0))) {
        result += steps;
        print('$steps: ${i/lines.length}');
        break;
      }
      steps++;
    }
    i++;
  }
  print(result);
}

bool recurse(int steps, Iterable<int> switches, int goal, int current) {
  for (int switch_ in switches) {
    if (switch_ ^ current == goal) {
      return true;
    }
  }
  if (steps == 1) {
    return false;
  }
  for (int switch_ in switches) {
    if (recurse(steps - 1, switches, goal, current ^ switch_)) {
      return true;
    }
  }
  return false;
}

bool eq<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  int i = 0;
  while (i < a.length) {
    if (a[i] != b[i]) return false;
    i++;
  }
  return true;
}

bool over<T extends num>(List<T> current, List<T> goal) {
  assert (current.length == goal.length);
  int i = 0;
  while (i < current.length) {
    if (current[i] > goal[i]) return false;
    i++;
  }
  return true;
}

List<int> add(List<int> a, List<int> b) {
  assert(a.length == b.length);
  List<int> r = List.filled(a.length, 0);
  int i = 0;
  while (i < a.length) {
    r[i] = a[i] + b[i];
    i++;
  }
  return r;
}

bool recurse2(
  int steps,
  Iterable<List<int>> switches,
  List<int> goal,
  List<int> current,
) {
  for (List<int> switch_ in switches) {
    if (eq(add(switch_, current), goal)) {
      return true;
    }
  }
  if (steps == 1) {
    return false;
  }
  for (List<int> switch_ in switches) {
    if (recurse2(steps - 1, switches, goal, add(current, switch_))) {
      return true;
    }
  }
  return false;
}
