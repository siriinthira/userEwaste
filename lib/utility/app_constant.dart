import 'package:flutter/material.dart';

class AppConstant {
  static String pageSignin = '/singin';
  static String pageMainHomeUser = '/User';
  static String pageMainHomeDriver = '/Driver';

  TextStyle h1Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 36,
      color: color,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  TextStyle h2Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 22,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  TextStyle h3Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 14,
      color: color,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
