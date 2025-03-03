import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/screens/sudoku_screen.dart';

import '../service/bottom_sheet_custom.dart';
import '../states/sudoku_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Судоку"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                BottomSheetCustom.show(context, (level) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => SudokuScreen(level: level)));
                });
              },
              child: const Text("Новая игра"))
        ],
      ),
    );
  }
}
