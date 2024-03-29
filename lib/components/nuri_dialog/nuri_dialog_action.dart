import 'package:flutter/cupertino.dart';

/// 弹窗按钮的设置
class DialogAction {
  /// 按钮文字
  final String title;

  /// 按钮点击事件
  final VoidCallback action;

  /// 是否高亮按钮，绿颜色
  final bool highlight;

  /// 是否警告按钮，红颜色
  final bool alert;

  /// 是否取消按钮， 70% 黑
  final bool isCancel;

  DialogAction(
      {required this.title,
      this.isCancel = false,
      required this.action,
      this.highlight = false,
      this.alert = false});
}
