import '../utils/index.dart';

class Day07 extends GenericDay {
  Day07() : super(7);

  @override
  List<List<int>> parseInput() {
    return input
        .getPerLine()
        .map((e) => e.replaceAll(':', '').split(' ').map(int.parse).toList())
        .toList();
  }

  @override
  int solvePart1() {
    final input = parseInput();
    var total = 0;
    for (final line in input) {
      final first = line.first;
      line.removeAt(0);
      if (match(first, line)) {
        // print('match: $line');
        total += first;
      } else {
        // print('no match: $line');
      }
    }
    return total;
  }

  @override
  int solvePart2() {
    final input = parseInput();
    var total = 0;
    for (final line in input) {
      final first = line.first;
      line.removeAt(0);
      if (match2(first, line)) {
        print('match: $line');
        total += first;
      } else {
        print('no match: $line');
      }
    }
    return total;
  }

  bool match(int first, List<int> line, [int total = 0]) {
    if (line.length == 1) {
      if (line.first + total == first || line.first * total == first) {
        return true;
      } else {
        return false;
      }
    } else {
      final current = line.first;
      return match(first, line.sublist(1), total + current) ||
          match(first, line.sublist(1), total * current);
    }
  }

  bool match2(int first, List<int> line, [int total = 0]) {
    if (line.length == 1) {
      if (line.first + total == first ||
          line.first * total == first ||
          int.parse(total.toString() + line.first.toString()) == first) {
        return true;
      } else {
        return false;
      }
    } else {
      final current = line.first;
      // print('Concat: ${int.parse(total.toString() + current.toString())}');
      return match2(first, line.sublist(1), total + current) ||
          match2(first, line.sublist(1), total * current) ||
          (total > 0 &&
              match2(first, line.sublist(1),
                  int.parse(total.toString() + current.toString())));
    }
  }
}
