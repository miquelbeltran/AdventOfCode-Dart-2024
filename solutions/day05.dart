import 'dart:math';

import 'package:test/test.dart';

import '../utils/index.dart';

class Day05 extends GenericDay {
  Day05() : super(5);

  Map<int, List<int>> order = {};
  List<List<int>> pages = [];

  @override
  parseInput() {
    order = {};
    pages = [];
    final lines = input.getPerLine();
    var i = 0;
    var line = lines[0];
    while (line.isNotEmpty) {
      final pair = line.split('|');
      final id = int.parse(pair[0]);
      final second = int.parse(pair[1]);
      order[id] = (order[id] ?? []) + [second];
      i++;
      line = lines[i];
    }
    // print(order);
    // skip empty line
    i++;
    while (i < lines.length) {
      line = lines[i];
      final page = line.split(',').map(int.parse).toList();
      pages.add(page);
      i++;
    }
    // print(pages);
  }

  @override
  int solvePart1() {
    parseInput();
    var total = 0;
    for (final page in pages) {
      bool correct = true;
      int i = 0;
      while (i < page.length) {
        final current = page[i];
        final orders = order[current] ?? [];
        var j = i + 1;
        while (j < page.length) {
          final next = page[j];
          if (!orders.contains(next)) {
            correct = false;
            break;
          }
          j++;
        }
        if (!correct) {
          break;
        }
        i++;
      }
      if (correct) {
        // print('correct: $page');
        final index = page.length ~/ 2;
        total += page[index];
      }
    }
    return total;
  }

  @override
  int solvePart2() {
    parseInput();
    var total = 0;
    for (final page in pages) {
      bool correct = true;
      int i = 0;
      while (i < page.length) {
        final current = page[i];
        final orders = order[current] ?? [];
        var j = i + 1;
        while (j < page.length) {
          final next = page[j];
          if (!orders.contains(next)) {
            correct = false;
            break;
          }
          j++;
        }
        if (!correct) {
          break;
        }
        i++;
      }
      if (!correct) {
        page.sortByCompare((e) => e, (a, b) {
          // print('a: $a, b: $b');
          if (!order.containsKey(a)) {
            return 1;
          }
          return order[a]!.contains(b) ? -1 : 1;
        });

        // print('!correct: $page');
        final index = page.length ~/ 2;
        total += page[index];
      }
    }
    return total;
  }
}
