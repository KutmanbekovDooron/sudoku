import 'dart:math';

import 'package:sudoke/modals/level_model.dart';
import 'package:sudoke/modals/sudoku_model.dart';

class SudokuBoard {
  late List<List<Sudoku>> board;

  List<List<int>> solution;
  final levelEnum level;

  SudokuBoard(this.solution, this.level) {
    board = List.generate(9, (_) => List.filled(9, Sudoku(0, false)));
    _copySolutionToBoard(level);
  }

  void _copySolutionToBoard(levelEnum level) {
    Random random = Random();
    int clues = getLevelValue(level);
    Set<int> positions = {};

    while (positions.length < clues) {
      int block = random.nextInt(9);
      int index = random.nextInt(9);
      positions.add(block * 9 + index);
    }

    for (int pos in positions) {
      int block = pos ~/ 9;
      int index = pos % 9;
      board[block][index] = Sudoku(solution[block][index], true);
    }
  }

  void placeNumber(int block, int index, int num) {
    if (!board[block][index].fixed && solution[block][index] == num) {
      board[block][index] = Sudoku(num, true);
    }
  }

  bool isComplete() {
    return board.every((block) => block.every((cell) => cell.number != 0));
  }

  int getLevelValue(levelEnum level) {
    switch (level) {
      case levelEnum.fast:
        return 62;
      case levelEnum.easy:
        return 50;
      case levelEnum.normal:
        return 39;
      case levelEnum.hard:
        return 38;
      case levelEnum.expert:
        return 28;
      case levelEnum.extreme:
        return 19;
      default:
        return 20;
    }
  }
}
