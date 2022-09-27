import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/nuri_switcher.dart';
import 'package:nuri/components/ui_button.dart';

import '../../ui_theme/ui_color.dart';
import '../../ui_theme/ui_text_style.dart';

class EditBasicInfo extends StatefulWidget {
  const EditBasicInfo({Key? key}) : super(key: key);

  @override
  State<EditBasicInfo> createState() => _EditBasicInfoState();
}

class _EditBasicInfoState extends State<EditBasicInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 24,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(40) // 限制长度
              ],
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              controller: TextEditingController(),
              cursorRadius: Radius.circular(0),
              cursorColor: UiColor.white,
              style: UiTextStyles.n17(color: UiColor.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入昵称",
                hintStyle: UiTextStyles.n17(color: UiColor.grey3),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(71, 74, 81, 1))),
        SizedBox(
          height: 16,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 5,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(40) // 限制长度
              ],
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              controller: TextEditingController(),
              cursorRadius: Radius.circular(0),
              cursorColor: UiColor.white,
              style: UiTextStyles.n17(color: UiColor.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "简介",
                hintStyle: UiTextStyles.n17(color: UiColor.grey3),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(71, 74, 81, 1))),
        SizedBox(
          height: 31,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "联系方式",
                style: UiTextStyles.n14(color: UiColor.grey3),
              ),
            ),
            Container(
              child: NuriSwitcher(initialStatus: false),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(40) // 限制长度
              ],
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              controller: TextEditingController(),
              cursorRadius: Radius.circular(0),
              cursorColor: UiColor.white,
              style: UiTextStyles.n17(color: UiColor.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "微信号",
                hintStyle: UiTextStyles.n17(color: UiColor.grey3),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(71, 74, 81, 1))),
        SizedBox(
          height: 16,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(40) // 限制长度
              ],
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              controller: TextEditingController(),
              cursorRadius: Radius.circular(0),
              cursorColor: UiColor.white,
              style: UiTextStyles.n17(color: UiColor.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "手机号码",
                hintStyle: UiTextStyles.n17(color: UiColor.grey3),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(71, 74, 81, 1))),
        SizedBox(
          height: 16,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(40) // 限制长度
              ],
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              controller: TextEditingController(),
              cursorRadius: Radius.circular(0),
              cursorColor: UiColor.white,
              style: UiTextStyles.n17(color: UiColor.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "邮箱地址",
                hintStyle: UiTextStyles.n17(color: UiColor.grey3),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(71, 74, 81, 1))),
        SizedBox(
          height: 36,
        ),
        UiButton(
          onClick: () {
            
          },
          buttonHeight: 48,
          buttonWidth: Get.width,
          borderRadius: 8,
          textColor: UiColor.black,
          text: "保存",
          buttonColor: UiColor.white,
        )
      ]),
    );
  }
}
