import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/modals/level_model.dart';
import 'package:sudoku/service/sudoku_generate.dart';
import 'package:sudoku/states/sudoku_state.dart';
import '../modals/active_model.dart';
import '../service/bottom_sheet_custom.dart';
import '../service/sudoku_service.dart';

class SudokuProvider extends StatelessWidget {
  final levelEnum level;

  const SudokuProvider({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SudokuState(),
      child: SudokuScreen(level: level),
    );
  }
}

class SudokuScreen extends StatefulWidget {
  final levelEnum level;

  const SudokuScreen({super.key, required this.level});

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  @override
  void initState() {
    super.initState();
    _generateSudoku(widget.level);
  }

  Future<void> _generateSudoku(levelEnum level) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SudokuState>().generateSudoku(level);
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Поздравляем!"),
        content: const Text("Вы решили Судоку!"),
        actions: [
          TextButton(
            onPressed: () {
              BottomSheetCustom.show(context, (level) {
                _generateSudoku(level);
                Navigator.pop(context);
              });
            },
            child: const Text("Новая игра"),
          ),
        ],
      ),
    );
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
              Consumer<SudokuState>(builder: (context, state, child) {
                // var sudoku = state.sudoku;
                return state.isLoading
                    ? const CircularProgressIndicator()
                    : Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff00374E))),
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
                                  border: Border.all(
                                      color: const Color(0xff00374E)),
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
                                        state.changeActive(
                                            ActiveIndex(block, index));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            color:
                                                state.colorIndex(block, index)),
                                        child: Center(
                                            child: Text(
                                                state.sudoku.board[block][index]
                                                            .number ==
                                                        0
                                                    ? ""
                                                    : state
                                                        .sudoku
                                                        .board[block][index]
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
                      );
              }),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ...List.generate(
                    9,
                    (index) => Consumer<SudokuState>(
                      builder: (context, state, child) {
                        int amount = state.filterNumbers(index + 1);
                        return Expanded(
                          child: Visibility(
                            visible: amount != 0,
                            child: GestureDetector(
                              onTap: () {
                                bool isComplete = context
                                    .read<SudokuState>()
                                    .onNumberTap(index + 1);
                                if (isComplete) {
                                  _showWinDialog();
                                }
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
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "${index + 1}", style: const TextStyle(
                                          color: Colors.blueAccent, fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Text('$amount' , style: const TextStyle(color: Colors.grey),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
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
