import 'package:flutter/material.dart';
import 'package:weather/presentation/resources/colors_manager.dart';
import 'package:weather/presentation/resources/styles_manager.dart';
import 'package:weather/presentation/resources/values_manager.dart';

import 'font_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.lightBlueAccent[700],
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
      ),
      textTheme: TextTheme(
        headline1: getMediumStyle(color: ColorManger.whiteColor),
        headline2: getMediumStyle(
            color: ColorManger.whiteColor, fontSize: FontSizeManger.s18),
        headline3: getMediumStyle(
            color: ColorManger.whiteColor, fontSize: FontSizeManger.s22),
        headline4: getMediumStyle(
            color: ColorManger.whiteColor, fontSize: FontSizeManger.s24),
        headline5: getBoldStyle(
            color: ColorManger.whiteColor, fontSize: FontSizeManger.s30),
        headline6: getBoldStyle(
            color: ColorManger.whiteColor, fontSize: FontSizeManger.s80),
        bodyText1: getMediumStyle(
            color: ColorManger.blackColor, fontSize: FontSizeManger.s30),
        bodyText2: getMediumStyle(
            color: ColorManger.blackColor, fontSize: FontSizeManger.s24),
      ),
      cardTheme: CardTheme(
        elevation: AppSize.s10,
        shadowColor: ColorManger.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s15),
        ),
      ));
}
