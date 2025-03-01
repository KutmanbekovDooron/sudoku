import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoke/components/level_bottom_sheet.dart';
import 'package:sudoke/modals/level_model.dart';
import 'package:sudoke/screens/sudoku_screen.dart';

import '../service/bottom_sheet_custom.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

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
