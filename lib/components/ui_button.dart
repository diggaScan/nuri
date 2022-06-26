import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

class UiButton extends StatefulWidget {
  final String? text;
  final Color? textColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? buttonColor;
  final Function? onClick;
  final double? borderRadius;
  final Color? borderColor;
  final TextStyle? textStyle;
  const UiButton(
      {Key? key,
      this.text,
      this.textColor,
      this.buttonHeight,
      this.buttonColor,
      this.buttonWidth,this.onClick,this.borderRadius,this.borderColor,this.textStyle})
      : super(key: key);

  @override
  State<UiButton> createState() => _UiButtonState();
}

class _UiButtonState extends State<UiButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.onClick!=null){
          widget.onClick!();
        }
      },
      child: Container(
        height: widget.buttonHeight ?? 0,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? UiColor.white,
          border: Border.all(width: 1,color: widget.borderColor??UiColor.white),
          borderRadius: BorderRadius.circular(widget.borderRadius??0),
        ),
        child: Center(
          child: Text("${widget.text}",
              style: widget.textStyle==null?UiTextStyles.b17(color: widget.textColor):widget.textStyle),
        ),
      ),
    );
  }
}
