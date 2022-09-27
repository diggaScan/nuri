import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../ui_theme/ui_color.dart';
import 'nuri_dialog.dart';
import 'nuri_dialog_action.dart';

class DialogUtils {
  static showBottomUpDialogWithFrame(BuildContext context, Widget content) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 184,
            decoration: BoxDecoration(
                color: UiColor.bottomSheetBkg,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            width: Get.width,
            child: content,
          );
        });
  }

  /// 快捷展示自定义弹窗的方法
  static Future<T?> showDialog<T>(BuildContext context,
      {String? title,
      String? content,
      Widget? contentWidget,
      required List<DialogAction> actions,
      RouteSettings? routeSettings}) {
    return showCupertinoDialog<T>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return NuriDialog(
              title: title,
              content: content,
              contentWidget: contentWidget,
              actions: actions);
        },
        routeSettings: routeSettings);
  }
}
