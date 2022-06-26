import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ErrorPageActionCallback = Function();

class ErrorPage extends StatelessWidget {
  final ErrorPageActionCallback? callback;
  final String? title;
  final bool bShowBack;
  final bool showButton;
  final Color? backgroundColor;

  ErrorPage(
      {this.title,
      this.callback,
      this.bShowBack = false,
      this.backgroundColor,
      this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title ?? '遇到错误'),
          SizedBox(height: 16),
        
        ],
      ),
    );
  }
}
