import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sudoku/modals/active_model.dart';
import 'package:sudoku/modals/level_model.dart';
import 'package:sudoku/modals/sudoku_model.dart';

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

  Color? colorIndex(block, index, ActiveIndex activeIndex) {
    var value = board[block][index].number;
    var activeValue = board[activeIndex.block][activeIndex.index].number;

    int startBlock = (activeIndex.block ~/ 3) * 3;
    int startIndex = (activeIndex.index ~/ 3) * 3;

    bool isSameBox = (block >= startBlock && block < startBlock + 3) &&
        (index >= startIndex && index < startIndex + 3);

    int relativeBlock = activeIndex.block % 3;
    int relativeIndex = activeIndex.index % 3;

    bool isSameRelativePosition =
        (block % 3 == relativeBlock) && (index % 3 == relativeIndex);

    if (block == activeIndex.block && index == activeIndex.index) {
      return const Color(0xff8fc9fa);
    } else if (activeValue == value && activeValue != 0) {
      return const Color(0xffb1cff1);
    } else if (block == activeIndex.block ||
        isSameRelativePosition ||
        isSameBox) {
      return Colors.grey.shade200;
    }
    return null;
  }


}
