import 'dart:math';

class SudokuGenerate {
  List<List<int>> generateBoard() {
    List<List<int>> grid = List.generate(9, (_) => List.filled(9, 0));
    solveSudoku(grid, 0, 0);
    return grid;
  }

  bool solveSudoku(List<List<int>> grid, int bloc, int index) {
    if (bloc == 9) return true;
    if (index == 9) return solveSudoku(grid, bloc + 1, 0);
    if (grid[bloc][index] != 0) return solveSudoku(grid, bloc, index + 1);

    List<int> numbers = List.generate(9, (index) => index + 1)
      ..shuffle(Random());

    for (int num in numbers) {
      if (isValidMove(grid, bloc, index, num)) {
        grid[bloc][index] = num;
        if (solveSudoku(grid, bloc, index + 1)) return true;
        grid[bloc][index] = 0;
      }
    }
    return false;
  }

  bool isValidMove(List<List<int>> grid, int block, int index, int num) {
    // Проверка внутри блока
    for (int i = 0; i < 9; i++) {
      if (grid[block][i] == num) return false;
    }

    // Проверка по горизонтали
    int blockStart = (block ~/ 3) * 3;
    int indexStart = (index ~/ 3) * 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[blockStart + i][indexStart + j] == num) return false;
      }
    }

    // Проверка по вертикале
    int relativeBlock = block % 3;
    int relativeIndex = index % 3;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (i != block &&
            j != index &&
            i % 3 == relativeBlock &&
            j % 3 == relativeIndex &&
            grid[i][j] == num) {
          return false;
        }
      }
    }

    return true;
  }
}
