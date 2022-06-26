import 'dart:io';

import 'package:flutter/painting.dart';

class UiTextStyles {
  UiTextStyles._();

  /// 数字文本默认字体
  static String? _defaultNumFontFamily;

  /// 设置数字默认字体，通过该方法设定后，[number]方法才会起作用
  static setDefaultNumFontFamily(String fontFamily) {
    _defaultNumFontFamily = fontFamily;
  }

  /// 获取数字类型文本的字体样式
  static TextStyle number(
    double fontSize, {
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) =>
      TextStyle(
        fontFamily: _defaultNumFontFamily,
        fontSize: fontSize,
        height: height,
        color: color,
      );

  /// 34号字体，加粗
  static TextStyle b34(
          {Color? color, double? height = 44 / 34.0, bool? bold = true}) =>
      style(color: color, size: 34, height: height, bold: bold);

  /// 28号字体，加粗
  static TextStyle b28(
          {Color? color, double? height = 36.0 / 28.0, bool? bold = true}) =>
      style(color: color, size: 28, height: height, bold: bold);

  /// 24号字体，加粗
  static TextStyle b24(
          {Color? color, double? height = 32.0 / 24.0, bool? bold = true}) =>
      style(color: color, size: 24, height: height, bold: bold);

  /// 20号字体，加粗
  static TextStyle b20(
          {Color? color, double? height = 28.0 / 20.0, bool? bold = true}) =>
      style(color: color, size: 20, height: height, bold: bold);

  /// 17号字体，加粗
  static TextStyle b17(
          {Color? color, double? height = 24.0 / 17.0, bool? bold = true}) =>
      style(color: color, size: 17, height: height, bold: bold);

  /// 17号字体
  static TextStyle n17(
          {Color? color, double? height = 24.0 / 17.0, bool? bold = false}) =>
      style(color: color, size: 17, height: height, bold: bold);

  /// 16号字体，加粗
  static TextStyle b16(
          {Color? color, double? height = 24.0 / 16.0, bool? bold = true}) =>
      style(color: color, size: 16, height: height, bold: bold);

  /// 16号字体
  static TextStyle n16(
          {Color? color, double? height = 24.0 / 16.0, bool? bold = false}) =>
      style(color: color, size: 16, height: height, bold: bold);

  /// 15号字体，加粗
  static TextStyle b15(
          {Color? color, double? height = 22.0 / 15.0, bool? bold = true}) =>
      style(color: color, size: 15, height: height, bold: bold);

  /// 15号字体
  static TextStyle n15(
          {Color? color, double? height = 22.0 / 15.0, bool? bold = false}) =>
      style(color: color, size: 15, height: height, bold: bold);

  /// 14号字体，加粗
  static TextStyle b14(
          {Color? color, double? height = 20.0 / 14.0, bool? bold = true}) =>
      style(color: color, size: 14, height: height, bold: bold);

  /// 14号字体
  static TextStyle n14(
          {Color? color, double? height = 20.0 / 14.0, bool? bold = false}) =>
      style(color: color, size: 14, height: height, bold: bold);

  /// 12号字体
  static TextStyle n12(
          {Color? color, double? height = 18.0 / 12.0, bool? bold = false}) =>
      style(color: color, size: 12, height: height, bold: bold);

  /// 10号字体
  static TextStyle n10(
          {Color? color, double? height = 14.0 / 10.0, bool? bold = false}) =>
      style(color: color, size: 10, height: height, bold: bold);

  static TextStyle style(
          {required Color? color,
          required double? size,
          required double? height,
          required bool? bold}) =>
      TextStyle(
          fontSize: size,
          height: height,
          color: color,
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal);

  List<TextStyle> get buildinStyles => [
        b34(),
        b28(),
        b24(),
        b20(),
        b17(),
        b16(),
        b15(),
        b14(),
        n17(),
        n16(),
        n15(),
        n14(),
        n12(),
        n10()
      ];
}
