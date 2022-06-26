import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final Color? backgroundColor;

  const LoadingPage({Key? key, this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        radius: 14,
      ),
    );
  }
}
