import '../utils/index.dart';

class Day08 extends GenericDay {
  Day08() : super(8);

  @override
  Field<String> parseInput() {
    return Field(input.getPerLine().map((e) => e.split('')).toList());
  }

  @override
  int solvePart1() {
    final field = parseInput();
    // print(field);
    final antennas = <String, List<Position>>{};
    for (var i = 0; i < field.height; i++) {
      for (var j = 0; j < field.width; j++) {
        final value = field.getValueAt(j, i);
        if (value != '.') {
          antennas[value] =
              antennas[value] != null ? antennas[value]! + [(j, i)] : [(j, i)];
        }
      }
    }

    print(antennas);

    for (final key in antennas.keys) {
      final positions = antennas[key]!;
      for (var i = 0; i < positions.length; i++) {
        for (var j = i + 1; j < positions.length; j++) {
          final (x1, y1) = positions[i];
          final (x2, y2) = positions[j];
          final (dx, dy) = ((x1 - x2), (y1 - y2));
          final node1 = ((x1 + dx), (y1 + dy));
          final node2 = ((x2 - dx), (y2 - dy));
          print('($x1, $y1) - ($x2, $y2): $dx, $dy -> $node1, $node2');
          if (field.isOnField(node1)) {
            final value = field.getValueAtPosition(node1);
            // if (value == '.') {
            field.setValueAtPosition(node1, '#');
            // }
          }
          if (field.isOnField(node2)) {
            final value = field.getValueAtPosition(node2);
            // if (value == '.') {
            field.setValueAtPosition(node2, '#');
            // }
          }
        }
      }
    }

    print(field);

    return field.count('#');
  }

  @override
  int solvePart2() {
    final field = parseInput();
    // print(field);
    final antennas = <String, List<Position>>{};
    for (var i = 0; i < field.height; i++) {
      for (var j = 0; j < field.width; j++) {
        final value = field.getValueAt(j, i);
        if (value != '.') {
          antennas[value] =
              antennas[value] != null ? antennas[value]! + [(j, i)] : [(j, i)];
        }
      }
    }

    print(antennas);

    for (final key in antennas.keys) {
      final positions = antennas[key]!;
      for (var i = 0; i < positions.length; i++) {
        for (var j = i + 1; j < positions.length; j++) {
          final (x1, y1) = positions[i];
          final (x2, y2) = positions[j];
          field.setValueAtPosition(positions[i], '#');
          field.setValueAtPosition(positions[j], '#');
          final (dx, dy) = ((x1 - x2), (y1 - y2));
          var node1 = ((x1 + dx), (y1 + dy));
          while (field.isOnField(node1)) {
            field.setValueAtPosition(node1, '#');
            node1 = ((node1.$1 + dx), (node1.$2 + dy));
          }
          var node2 = ((x2 - dx), (y2 - dy));
          while (field.isOnField(node2)) {
            field.setValueAtPosition(node2, '#');
            node2 = ((node2.$1 - dx), (node2.$2 - dy));
          }
        }
      }
    }

    print(field);

    return field.count('#');
  }
}
