import '../utils/index.dart';

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  Field<String> parseInput() {
    return Field(input.getPerLine().map((e) => e.split('')).toList());
  }

  final directions = [
    // (0, 0), // stay
    (1, 0), // down
    (-1, 0), // up
    (0, 1), // right
    (0, -1), // left
    (1, 1), // down-right
    (1, -1), // down-left
    (-1, 1), // up-right
    (-1, -1), // up-left
  ];

  final crossDirections = [
    (1, 1), // down-right
    (1, -1), // down-left
    (-1, 1), // up-right
    (-1, -1), // up-left
  ];

  String getWordDirection(
    int ox, // origin x
    int oy, // origin y
    Field<String> field,
    (int, int) direction,
    int length,
  ) {
    final (dx, dy) = direction;
    var word = field.getValueAt(ox, oy);
    for (var i = 1; i < length; i++) {
      final x = ox + dx * i;
      final y = oy + dy * i;
      if (field.isOnField((x, y))) {
        word += field.getValueAt(x, y);
      } else {
        break;
      }
    }
    return word;
  }

  int checkIfXmas(int i, int j, Field<String> field) {
    var count = 0;
    final current = field.getValueAt(i, j);
    if (current != 'X') {
      return 0;
    }
    // print('($j, $i): $current');

    for (final direction in directions) {
      final word = getWordDirection(i, j, field, direction, 4);
      if (word == 'XMAS') {
        // print('($i, $j) $direction $word');
        count++;
      }
    }

    // print('Count: $count in $j, $i');
    return count;
  }

  int checkIfMAS(int i, int j, Field<String> field) {
    final current = field.getValueAt(i, j);
    print('($j, $i): $current');
    if (current != 'A') {
      return 0;
    }

    var topLeft = field.getValueAt(i - 1, j - 1);
    var topRight = field.getValueAt(i + 1, j - 1);
    var botLeft = field.getValueAt(i - 1, j + 1);
    var botRight = field.getValueAt(i + 1, j + 1);

    var cross1 = topLeft + current + botRight;
    var cross2 = topRight + current + botLeft;

    if ((cross1 == 'MAS' || cross1 == 'SAM') &&
        (cross2 == 'MAS' || cross2 == 'SAM')) {
      print('FOUND ($i, $j) $cross1 $cross2');
      return 1;
    }

    print('NOTFN ($i, $j) $cross1 $cross2');
    return 0;
  }

  @override
  int solvePart1() {
    final field = parseInput();
    var count = 0;
    for (var i = 0; i < field.height; i++) {
      for (var j = 0; j < field.width; j++) {
        count += checkIfXmas(i, j, field);
      }
    }
    return count;
  }

  @override
  int solvePart2() {
    final field = parseInput();
    var count = 0;
    for (var x = 1; x < field.width - 1; x++) {
      for (var y = 1; y < field.height - 1; y++) {
        count += checkIfMAS(x, y, field);
      }
    }
    return count;
  }
}
