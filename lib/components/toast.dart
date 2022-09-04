import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../ui_theme/ui_color.dart';

class NuriToast {
  static show(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        webPosition: "center",
        backgroundColor: UiColor.black.withOpacity(0.3),
        textColor: Colors.white,
        webBgColor: "linear-gradient(to right, #000000b2, #000000b2)",
        fontSize: 14);
  }
}
