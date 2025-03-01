import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modals/level_model.dart';
import '../screens/sudoku_screen.dart';

class LevelBottomSheet extends StatelessWidget {
  final void Function(levelEnum) onLevelClick;
  LevelBottomSheet({super.key, required this.onLevelClick});

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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: levels.length,
      itemBuilder: (modalContext, index) {
        return ListTile(
          title: Center(child: Text(levels[index].name)),
          onTap: () {
            Navigator.pop(modalContext);
            onLevelClick(levels[index].level);
          },
        );
      },
    );
    ;
  }
}
