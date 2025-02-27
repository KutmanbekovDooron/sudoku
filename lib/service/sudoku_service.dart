import 'dart:math';

import 'package:sudoke/modals/sudoku_model.dart';

class SudokuBoard {
  late List<List<Sudoku>> board ;
  List<List<int>> solution;


  SudokuBoard(this.solution) {
    board = List.generate(9, (_) => List.filled(9, Sudoku(0, false)));
    _copySolutionToBoard();
  }

  void _copySolutionToBoard() {
    Random random = Random();
    int clues = 81;
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

}
