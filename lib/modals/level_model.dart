class LevelModel {
  final String name;
  final levelEnum level;

  LevelModel(this.name, this.level);
}

enum levelEnum {
  fast,
  easy,
  normal,
  hard,
  expert,
  extreme
}