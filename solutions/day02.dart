import '../utils/index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<List<int>> parseInput() {
    return input
        .getPerLine()
        .map((e) => e.split(' ').map(int.parse).toList())
        .toList();
  }

  @override
  int solvePart1() {
    final input = parseInput();
    var count = 0;
    for (final line in input) {
      // print(line);
      var safe = true;
      var diff = 0;
      var previous = line[0];
      for (var i = 1; i < line.length; i++) {
        final current = line[i];
        final newDiff = current - previous;
        if (diff == 0) {
          diff = newDiff;
          // print('diff is $diff');
        }
        if (newDiff < -3 || newDiff > 3 || newDiff == 0) {
          // print('$newDiff is not -3 to 3');
          safe = false;
          break;
        } else if (diff > 0 && newDiff < 0) {
          // print('newdiff: $newDiff but diff: $diff is positive');
          safe = false;
          break;
        } else if (diff < 0 && newDiff > 0) {
          // print('newdiff: $newDiff but diff: $diff is negative');
          safe = false;
          break;
        }
        previous = current;
      }
      if (safe) {
        count++;
      }
    }
    return count;
  }

  bool isSave(List<int> line) {
    var safe = true;
    var diff = 0;
    var previous = line[0];
    for (var i = 1; i < line.length; i++) {
      final current = line[i];
      final newDiff = current - previous;
      if (diff == 0) {
        diff = newDiff;
        // print('diff is $diff');
      }
      if (newDiff < -3 || newDiff > 3 || newDiff == 0) {
        // print('$newDiff is not -3 to 3');
        safe = false;
        break;
      } else if (diff > 0 && newDiff < 0) {
        // print('newdiff: $newDiff but diff: $diff is positive');
        print(line);
        safe = false;
        break;
      } else if (diff < 0 && newDiff > 0) {
        // print('newdiff: $newDiff but diff: $diff is negative');
        safe = false;
        break;
      }
      previous = current;
    }
    return safe;
  }

  @override
  int solvePart2() {
    final input = parseInput();
    var count = 0;
    for (final line in input) {
      if (isSave(line)) {
        count++;
        continue;
      } else {
        for (var i = 0; i < line.length; i++) {
          final newLine = List<int>.from(line);
          newLine.removeAt(i);
          if (isSave(newLine)) {
            count++;
            break;
          }
        }
      }
    }
    return count;
  }
}
