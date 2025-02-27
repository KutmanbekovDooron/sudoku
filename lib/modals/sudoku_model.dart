class Sudoku {
  int number;
  bool fixed;

  Sudoku(this.number, this.fixed);

  @override
  String toString() {
    return "number $number  fixed $fixed";
  }

}