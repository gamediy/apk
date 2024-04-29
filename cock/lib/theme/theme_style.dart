import 'dart:ui';

import 'package:flutter/material.dart';






class ThemeStyle {
  static double? ButtonFontSize = 16;
  static Color? BgColor = Color(0xfff5f7fb);
  static Color? BgColor1=Color(0xffffffff);
  static Color? Color1=Color(0xfff7f8fa);
  static Color? txtColor=Color(0xff83878a);
  static Decoration BoxBorderRadius = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
        10
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 70,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}