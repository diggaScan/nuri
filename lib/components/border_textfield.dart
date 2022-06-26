import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

/// 带边框的输入框
class BorderedTextfield extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final String? placeholder;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;

  static final style = UiTextStyles.n17(color: UiColor.grey3);
  static final placeholderStyle = UiTextStyles.n17(color: UiColor.grey3);
  final Function(String)? onChanged;

  const BorderedTextfield(
      {Key? key,
      this.focusNode,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.suffix,
      this.placeholder,
      this.prefix,
      this.autofocus = false,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  _BorderedTextfieldState createState() => _BorderedTextfieldState();
}

class _BorderedTextfieldState extends State<BorderedTextfield> {
  bool focus = false;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      setState(() {
        focus = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: _defaultPadding,
      placeholder: widget.placeholder,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      cursorColor: UiColor.brandingGreen,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onSubmitted: widget.onSubmitted,
      prefix: widget.prefix,
      onChanged: widget.onChanged,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: focus ? UiColor.brandingGreen : UiColor.grey3, width: 1)),
      suffix: widget.suffix,
      placeholderStyle: BorderedTextfield.placeholderStyle,
      style: BorderedTextfield.style,
    );
  }
}

/// 手机号码输入框
class PhoneNumberTextfield extends BorderedTextfield {
  const PhoneNumberTextfield(
      {FocusNode? focusNode,
      TextEditingController? controller,
      TextInputType? keyboardType,
      String? placeholder,
      bool autofocus = false,
      Widget? prefix,
      Widget? suffix,
      Function(String)? onChanged,
      ValueChanged<String>? onSubmitted})
      : super(
            suffix: suffix,
            prefix: prefix,
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyboardType,
            placeholder: placeholder,
            autofocus: autofocus,
            onChanged: onChanged,
            onSubmitted: onSubmitted);
}

/// 密码输入框
class PasswordTextfield extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? placeholder;
  final bool autofocus;

  const PasswordTextfield(
      {Key? key,
      this.focusNode,
      this.controller,
      this.keyboardType,
      this.placeholder,
      this.autofocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool>(
      initialValue: true,
      builder: (bool? snapshot, updater) => BorderedTextfield(
        placeholder: placeholder,
        autofocus: autofocus,
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: snapshot!,
        suffix: CupertinoButton(
          minSize: 30,
          padding: EdgeInsets.only(
              right: _defaultPadding.right, top: 4, bottom: 4, left: 4),
          child: Icon(!snapshot ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: UiColor.black),
          onPressed: () => updater(!snapshot),
        ),
      ),
    );
  }
}
