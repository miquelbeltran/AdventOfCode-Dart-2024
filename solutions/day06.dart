import 'dart:io';

import '../utils/index.dart';

class Day06 extends GenericDay {
  Day06() : super(6);

  @override
  Field<String> parseInput() {
    return Field(input.getPerLine().map((e) => e.split('')).toList());
  }

  final directions = {
    '^': (0, -1),
    'v': (0, 1),
    '>': (1, 0),
    '<': (-1, 0),
  };

  @override
  int solvePart1() {
    final field = parseInput();
    // find guard
    var x = 0;
    var y = 0;
    for (var i = 0; i < field.height; i++) {
      for (var j = 0; j < field.width; j++) {
        if (directions.containsKey(field.getValueAt(j, i))) {
          x = j;
          y = i;
          break;
        }
      }
    }
    // print('Guard at: ($x, $y)');

    var direction = directions[field.getValueAt(x, y)]!;
    field.setValueAt(x, y, 'X');
    var count = 1;

    while (true) {
      final (dx, dy) = direction;
      final nextX = x + dx;
      final nextY = y + dy;
      if (!field.isOnField((nextX, nextY))) {
        // print('escaped!');
        break;
      }
      final next = field.getValueAt(nextX, nextY);
      if (next == '#') {
        // print('wall at: ($nextX, $nextY)');
        // Rotate right
        if (direction == directions['^']) {
          direction = directions['>']!;
        } else if (direction == directions['>']) {
          direction = directions['v']!;
        } else if (direction == directions['v']) {
          direction = directions['<']!;
        } else if (direction == directions['<']) {
          direction = directions['^']!;
        }
        // print('new direction: $direction');
        continue;
      }
      // advance
      x = nextX;
      y = nextY;
      if (next == '.') {
        field.setValueAt(x, y, 'X');
        count++;
      }
    }

    return count;
  }

  (int, int) rotate((int, int) direction) {
    if (direction == directions['^']) {
      return directions['>']!;
    } else if (direction == directions['>']) {
      return directions['v']!;
    } else if (direction == directions['v']) {
      return directions['<']!;
    } else if (direction == directions['<']) {
      return directions['^']!;
    }
    throw Exception('Invalid direction: $direction');
  }

  String fromDirection((int, int) direction) {
    if (direction == directions['^']) {
      return '^';
    } else if (direction == directions['>']) {
      return '>';
    } else if (direction == directions['v']) {
      return 'v';
    } else if (direction == directions['<']) {
      return '<';
    }
    throw Exception('Invalid direction: $direction');
  }

  @override
  int solvePart2() {
    final field = parseInput();
    // find guard
    var ox = 0;
    var oy = 0;
    var oDirection = (0, 0);
    for (var i = 0; i < field.height; i++) {
      for (var j = 0; j < field.width; j++) {
        if (directions.containsKey(field.getValueAt(j, i))) {
          ox = j;
          oy = i;
          oDirection = directions[field.getValueAt(j, i)]!;
          break;
        }
      }
    }

    print('Guard at: ($ox, $oy, $oDirection)');

    // Navigate the field and store the visited points
    var x = ox;
    var y = oy;
    var direction = oDirection;
    field.setValueAt(x, y, '.');
    var count = 0;
    final visited = <(int, int)>{};

    while (true) {
      // visited.add((x, y, direction.$1, direction.$2));
      final (dx, dy) = direction;
      final nextX = x + dx;
      final nextY = y + dy;
      if (!field.isOnField((nextX, nextY))) {
        // print('escaped!');
        break;
      }
      final next = field.getValueAt(nextX, nextY);
      if (next == '#') {
        direction = rotate(direction);
        continue;
      }

      // advance
      x = nextX;
      y = nextY;
      visited.add((x, y));
    }

    // print(visited);

    // visited contains all the visited points
    // for each visited point, check if adding a blocker causes a loop
    print('Guard at: ($ox, $oy, $oDirection)');
    for (final block in visited) {
      if (hasLoop(field, ox, oy, oDirection, block)) {
        count++;
      }
    }

    return count;
  }

  bool hasLoop(
    Field<String> field,
    int ox,
    int oy,
    (int, int) oDirection,
    (int, int) block,
  ) {
    // final origin = ((ox, oy), oDirection);

    final corners = <((int, int), (int, int))>[];

    var direction = oDirection;
    var (x, y) = (ox, oy);
    var max = 10000;

    while (true) {
      final (dx, dy) = direction;
      final nextX = x + dx;
      final nextY = y + dy;
      if (!field.isOnField((nextX, nextY))) {
        // print('escaped!');
        return false;
      }
      final next = field.getValueAt(nextX, nextY);
      if (next == '#' || (nextX, nextY) == block) {
        if (corners.contains(((x, y), direction))) {
          return true;
        }
        corners.add(((x, y), direction));
        direction = rotate(direction);
        continue;
      }

      // advance
      x = nextX;
      y = nextY;

      max--;
      if (max == 0) {
        print('max reached');
        exit(1);
      }
    }
  }
}
