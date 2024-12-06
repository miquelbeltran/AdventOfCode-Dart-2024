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
    field.setValueAt(x, y, '.');
    var count = 0;

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

      if (hasLoop(field, x, y, direction)) {
        count++;
      }

      // advance
      x = nextX;
      y = nextY;
    }

    return count;
  }

  bool hasLoop(Field<String> field, int ox, int oy, (int, int) oDirection) {
    final blocker = (ox + oDirection.$1, oy + oDirection.$2);
    final origin = (ox, oy, oDirection);

    final visited = <(int, int, (int, int))>[origin];

    var direction = oDirection;
    var position = (ox, oy);
    var max = 10000;

    while (true) {
      max--;
      if (max == 0) {
        print('max reached');
        exit(1);
      }

      final nextPosition =
          (position.$1 + direction.$1, position.$2 + direction.$2);

      if (!field.isOnField(nextPosition)) {
        // escaped
        return false;
      }

      if ((nextPosition.$1, nextPosition.$2, direction) == origin) {
        // back to origin with same direction
        return true;
      }

      if (visited.contains((nextPosition.$1, nextPosition.$2, direction))) {
        // loop found
        return true;
      }

      if (nextPosition == blocker ||
          field.getValueAt(nextPosition.$1, nextPosition.$2) == '#') {
        // hit a wall, rotate and continue
        direction = rotate(direction);
        continue;
      }

      // advance
      position = nextPosition;
      visited.add((position.$1, position.$2, direction));
    }
  }
}
