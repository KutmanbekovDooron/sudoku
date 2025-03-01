import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoke/modals/level_model.dart';

import '../components/level_bottom_sheet.dart';

class BottomSheetCustom {
  static show(BuildContext context, Function(levelEnum) callBack) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return LevelBottomSheet(onLevelClick: callBack);
      },
    );
  }
}
