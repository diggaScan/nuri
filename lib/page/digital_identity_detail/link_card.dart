import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/infrastructure_layer/utils/utils.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';
import 'package:nuri/view_model_layer/data/link_etity.dart';
import 'package:nuri/view_model_layer/vm_add_link_page.dart';

class LinkCard extends StatefulWidget {
  static const String mode_edit = "mode_edit";
  static const String mode_info = "mode_info";
  final LinkEntity? linkEntity;

  const LinkCard({Key? key,this.linkEntity}) : super(key: key);

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  String mode = LinkCard.mode_info;

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case LinkCard.mode_edit:
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(49, 52, 57, 1)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Utils.getImgPath("empty_pic"),
                width: 48,
                height: 48,
              ),
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
                    cursorColor: UiColor.brandingGreen,
                    style: UiTextStyles.n17(color: UiColor.brandingGreen),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "链接标题",
                      hintStyle: UiTextStyles.n17(color: UiColor.grey3),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(71, 74, 81, 1))),
              SizedBox(
                height: 12,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1000) // 限制长度
                    ],
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    controller: TextEditingController(),
                    cursorRadius: Radius.circular(0),
                    cursorColor: UiColor.brandingGreen,
                    style: UiTextStyles.n17(color: UiColor.brandingGreen),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "链接URL",
                      hintStyle: UiTextStyles.n17(color: UiColor.grey3),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(71, 74, 81, 1))),
              SizedBox(
                height: 8,
              ),
              Text(
                "如何获取链接？",
                style: UiTextStyles.n10(color: UiColor.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: UiColor.alertRed,
                        size: 16,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "删除",
                        style: UiTextStyles.n10(color: UiColor.alertRed),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        Utils.getImgPath("hide_icon"),
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "显示",
                        style: UiTextStyles.n10(color: UiColor.grey4),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      UiButton(
                        onClick: () {
                          onClickCancel();
                        },
                        textStyle: UiTextStyles.n12(color: UiColor.white),
                        borderRadius: 20,
                        buttonHeight: 48,
                        buttonWidth: 56,
                        textColor: UiColor.white,
                        text: "取消",
                        buttonColor: UiColor.transparent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      UiButton(
                        onClick: () {
                          onClickConfirm();
                        },
                        textStyle: UiTextStyles.n12(color: UiColor.black),
                        borderRadius: 20,
                        buttonHeight: 48,
                        buttonWidth: 56,
                        textColor: UiColor.black,
                        text: "完成",
                        buttonColor: UiColor.white,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      case LinkCard.mode_info:
        return Container(
          height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(49, 52, 57, 1)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Utils.getImgPath("empty_pic"),
                      width: 48,
                      height: 48,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "链接标题",
                      style: UiTextStyles.b14(color: UiColor.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onClickEdit();
                      },
                      child: Image.asset(
                        Utils.getImgPath("pen_icon"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Utils.getImgPath("hide_icon"),
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                )
              ]),
        );

      default:
        return Container();
    }
  }

  onClickEdit() {
    setState(() {
      mode = LinkCard.mode_edit;
    });
  }

  onClickCancel() {
    setState(() {
      mode = LinkCard.mode_info;
    });
  }

  onClickConfirm() {
    setState(() {
      mode = LinkCard.mode_info;
    });
  }
  onClickRemove(){
   
  }
}
