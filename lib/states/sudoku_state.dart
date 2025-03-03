import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku/service/sudoku_generate.dart';

import '../modals/active_model.dart';
import '../modals/level_model.dart';
import '../service/sudoku_service.dart';

class SudokuState extends ChangeNotifier {
  bool isLoading = true;
  SudokuBoard sudoku = SudokuBoard([], levelEnum.fast);
  ActiveIndex activeIndex = ActiveIndex(0, 0);

  Future<void> generateSudoku(levelEnum level) async {
    isLoading = true;
    notifyListeners();
    var generatedSudoku =
        await compute((_) => SudokuGenerate().generateBoard(), null);
    sudoku = SudokuBoard(generatedSudoku, level);
    isLoading = false;
    notifyListeners();
  }

  bool onNumberTap(int num) {
    sudoku.placeNumber(activeIndex.block, activeIndex.index, num);
    notifyListeners();
    if (sudoku.isComplete()) {
      return true;
    }
    return false;
  }

  void changeActive(ActiveIndex active) {
    activeIndex = active;
    notifyListeners();
  }

  int filterNumbers (int number){
    if(sudoku.board.isNotEmpty) {
      int amount = 9;
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if(sudoku.board[i][j].number == number) {
            amount--;
          }
        }
      }
      return amount;
    }
    return 0;
  }


  Color? colorIndex(block, index) {
    var value = sudoku.board[block][index].number;
    var activeValue = sudoku.board[activeIndex.block][activeIndex.index].number;

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
      return const Color(0xffEEEEEE);
    }
    return null;
  }

}
