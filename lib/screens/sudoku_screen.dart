import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoke/modals/level_model.dart';
import 'package:sudoke/service/sudoku_generate.dart';
import '../modals/active_model.dart';
import '../service/sudoku_service.dart';

class SudokuScreen extends StatefulWidget {
  final levelEnum level;

  const SudokuScreen({super.key, required this.level});

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  late SudokuBoard sudoku;
  ActiveIndex activeIndex = ActiveIndex(0, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateSudoku();
  }

  Future<void> _generateSudoku() async {
    var generatedSudoku =
        await compute((_) => SudokuGenerate().generateBoard(), null);
    setState(() {
      sudoku = SudokuBoard(generatedSudoku, widget.level);
      isLoading = false;
    });
  }

  void onNumberTap(int mainIndex, int index, int num) {
    setState(() {
      sudoku.placeNumber(mainIndex, index, num);
      if (sudoku.isComplete()) {
        _showWinDialog();
      }
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Поздравляем!"),
        content: Text("Вы решили Судоку!"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _generateSudoku();
              Navigator.pop(context);
            },
            child: Text("Новая игра"),
          ),
        ],
      ),
    );
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
      return const Color(0xffACD6FA);
    } else if ((activeValue == value && activeValue != 0) ||
        block == activeIndex.block ||
        isSameRelativePosition ||
        isSameBox) {
      return const Color(0xffDCE6F0);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff00374E))),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          shrinkWrap: true,
                          itemCount: 9,
                          itemBuilder: (context, block) {
                            return Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff00374E)),
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: 9,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        activeIndex = ActiveIndex(block, index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          color: colorIndex(block, index)),
                                      child: Center(
                                          child: Text(
                                              sudoku.board[block][index]
                                                          .number ==
                                                      0
                                                  ? ""
                                                  : sudoku.board[block][index]
                                                      .number
                                                      .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                              ))),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ...List.generate(
                    9,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onNumberTap(
                              activeIndex.block, activeIndex.index, index + 1);
                        },
                        child: Container(
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 10)
                              ]),
                          child: Center(
                              child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
