import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(Color color, FontWeight fontWeight, double fontSize) {
  return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      overflow: TextOverflow.ellipsis);
}

getMediumStyle({required Color color, double fontSize = FontSizeManger.s20}) {
  return _getTextStyle(
    color,
    FontWeightManager.medium,
    fontSize,
  );
}

getBoldStyle({required Color color, double fontSize = FontSizeManger.s30}) {
  return _getTextStyle(
    color,
    FontWeightManager.bold,
    fontSize,
  );
}
