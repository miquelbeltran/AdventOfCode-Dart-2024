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
        direction = rotate(direction);
        field.setValueAt(x, y, fromDirection(direction));
        // print('new direction: $direction');
        continue;
      }

      // test if next direction finds a rotated direction
      final plusDirection = rotate(direction);
      var plusX = x;
      var plusY = y;
      while (true) {
        final (dx, dy) = plusDirection;
        plusX = plusX + dx;
        plusY = plusY + dy;
        if (!field.isOnField((plusX, plusY))) {
          break;
        }
        final next = field.getValueAt(plusX, plusY);
        if (next == fromDirection(rotate(plusDirection))) {
          // print('found $next at: ($plusX, $plusY)');
          // field.setValueAt(nextX, nextY, 'O');
          count++;
          break;
        }
      }

      // advance
      x = nextX;
      y = nextY;
    }

    print(field.toString());

    return count;
  }
}
