import '../utils/index.dart';

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  parseInput() {}

  @override
  int solvePart1() {
    // regex to match the input mul(x,y)
    final r = RegExp(r'mul\((\d+),(\d+)\)');
    var total = 0;
    r.allMatches(input.asString).forEach((match) {
      final x = int.parse(match.group(1)!);
      final y = int.parse(match.group(2)!);
      total += x * y;
    });
    return total;
  }

  @override
  int solvePart2() {
    return 0;
  }
}
