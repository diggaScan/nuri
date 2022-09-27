import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../TapEffectGesture.dart';
import 'nuri_dialog_action.dart';

double DefaultDialogWidth = 300;

enum DialogTheme {
  dark,
  light,
}

/// 自定义弹窗
class NuriDialog extends StatelessWidget {
  final DialogTheme theme;

  /// 弹窗标题
  final String? title;

  /// 弹窗描述信息，小字
  final String? content;

  final Widget? contentWidget;

  /// 弹窗按钮事件，从左到右，从上到下，按钮过多的情况，可能会超出屏幕高度，暂不支持滚动
  final List<DialogAction> actions;

  const NuriDialog({
    required this.title,
    this.content,
    required this.actions,
    this.theme = DialogTheme.dark,
    this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actionWidgets = [];

    var actionLength = actions.length;
    for (int i = 0; i < actionLength; i++) {
      var action = actions[i];
      Widget actionWidget = EffectGesture(
        onTap: action.action,
        child: Container(
          height: 55,
          child: Center(
            child: Text(
              action.title,
              style: UiTextStyles.b17().copyWith(
                  decoration: TextDecoration.none,
                  // 通常按钮文字为单行，重写他的高度，使其垂直居中
                  height: 1.3,
                  color: action.highlight
                      ? UiColor.brandingGreen
                      : (action.alert ? UiColor.alertRed : theme==DialogTheme.dark?UiColor.white:UiColor.black90)),
            ),
          ),
        ),
      );

      if (actionLength <= 2) {
        actionWidget = Expanded(child: actionWidget);
      }
      actionWidgets.add(actionWidget);
    }

    Widget actionContainer;
    if (actionLength <= 2) {
      List<Widget> children = [];
      for (var i = 0; i < actionWidgets.length; i++) {
        if (i > 0) {
          children.add(DialogDivider(
            horizontal: false,
          ));
        }
        children.add(actionWidgets[i]);
      }
      actionContainer = Row(
        children: children,
      );
    } else {
      List<Widget> children = [];
      for (var i = 0; i < actionWidgets.length; i++) {
        if (i > 0) {
          children.add(DialogDivider(
            horizontal: true,
          ));
        }
        children.add(actionWidgets[i]);
      }
      actionContainer = Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    var hasTitle = title != null && title!.isNotEmpty;
    var hasContent =
        (content != null && content!.isNotEmpty) || contentWidget != null;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Center(
        child: CupertinoPopupSurface(
          child: Container(
            width: DefaultDialogWidth,
            color: theme == DialogTheme.dark
                ? UiColor.bottomSheetBkg
                : UiColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 104),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                          child: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style: UiTextStyles.b17().copyWith(
                              decoration: TextDecoration.none,
                              color: theme == DialogTheme.dark
                                  ? UiColor.white
                                  : UiColor.bottomSheetBkg,
                            ),
                          ),
                          visible: hasTitle),
                      Visibility(
                        child: SizedBox(
                          height: 16,
                        ),
                        visible: hasContent,
                      ),
                      Visibility(
                        child: DefaultTextStyle(
                            style: UiTextStyles.n17().copyWith(
                              decoration: TextDecoration.none,
                            ),
                            child: contentWidget ??
                                Text(
                                  '$content',
                                  textAlign: TextAlign.center,
                                )),
                        visible: hasContent,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: UiColor.grey3,
                ),
                actionContainer
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 按钮的分割线
class DialogDivider extends StatelessWidget {
  final bool horizontal;

  const DialogDivider({Key? key, this.horizontal = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiColor.grey3,
      width: horizontal ? double.infinity : 0.5,
      height: horizontal ? 0.5 : 56,
    );
  }
}
