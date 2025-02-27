import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoke/modals/level_model.dart';
import 'package:sudoke/screens/sudoku_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<LevelModel> levels = [
    LevelModel('Быстрое', levelEnum.fast),
    LevelModel('Легкий', levelEnum.easy),
    LevelModel('Средний', levelEnum.normal),
    LevelModel('Сложный', levelEnum.hard),
    LevelModel('Эксперт', levelEnum.expert),
    LevelModel('Экстримальный', levelEnum.extreme),
  ];

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
                showModalBottomSheet(
                  context: context,
                    isScrollControlled: true,
                  builder: (BuildContext modalContext) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: levels.length,
                      itemBuilder: (modalContext, index) {
                        return ListTile(
                          title: Center(child: Text(levels[index].name)),
                          onTap: () {
                            Navigator.pop(modalContext);
                            Navigator.push(context, CupertinoPageRoute(builder: (_) => SudokuScreen(level: levels[index].level)));
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: const Text("Новая игра"))
        ],
      ),
    );
  }
}
