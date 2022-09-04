import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nuri/common/special_function.dart';

import '../ui_theme/ui_color.dart';
import '../ui_theme/ui_text_style.dart';

class VerifyCodeCountDownText extends StatefulWidget {
  final int? time;
  final Function? getContent;
  final Function? onEffectiveClick;
  const VerifyCodeCountDownText({Key? key, this.time, this.getContent,this.onEffectiveClick})
      : super(key: key);

  @override
  State<VerifyCodeCountDownText> createState() => _CountDownTextState();
}

class _CountDownTextState extends State<VerifyCodeCountDownText> {
  String str = '';
  Timer? timer;
  int count = 0;
  bool onCountDown = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = widget.time ?? 0;
    str = "获取验证码";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onCountDown) {
          return;
        } else {
          widget.onEffectiveClick!();
          SpecFunction().xuThrottle(() {
            startCountDown();
          });
        }
      },
      child: Text(
        str,
        style: onCountDown
            ? UiTextStyles.n14(color: UiColor.grey3)
            : UiTextStyles.n14(color: UiColor.white),
      ),
    );
  }

  startCountDown() {
    if ((count) > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (count <= 1) {
            timer.cancel();
            onCountDown = false;
            str = "获取验证码";
          } else {
            onCountDown = true;
            str = widget.getContent!(--count);
          }
        });
      });
    }
  }
}
