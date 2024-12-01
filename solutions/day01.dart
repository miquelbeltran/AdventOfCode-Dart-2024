import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  List<int> array1 = [];
  List<int> array2 = [];

  @override
  parseInput() {
    array1 = [];
    array2 = [];
    final lines = input.getPerLine();
    for (final line in lines) {
      if (line.isEmpty) {
        continue;
      }
      final parts = line.split('   ');
      array1.add(int.parse(parts[0]));
      array2.add(int.parse(parts[1]));
    }
  }

  @override
  int solvePart1() {
    parseInput();

    array1.sort();
    array2.sort();

    var result = 0;
    for (var i = 0; i < array1.length; i++) {
      result += (array1[i] - array2[i]).abs();
    }

    return result;
  }

  @override
  int solvePart2() {
    parseInput();

    final map = <int, int>{};
    for (var i = 0; i < array2.length; i++) {
      final val = array2[i];
      map[val] = (map[val] ?? 0) + val;
    }

    var result = 0;
    for (var i = 0; i < array1.length; i++) {
      result += map[array1[i]] ?? 0;
    }

    return result;
  }
}
