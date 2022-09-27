import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/nuri_switcher.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/infrastructure_layer/utils/utils.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';
import 'package:nuri/view_model_layer/data/link_etity.dart';
import 'package:nuri/view_model_layer/vm_add_link_page.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../../components/nuri_dialog/dialog_utils.dart';
import '../../components/nuri_dialog/nuri_dialog_action.dart';

class LinkCard extends StatefulWidget {
  static const String mode_edit = "mode_edit";
  static const String mode_info = "mode_info";
  final LinkEntity? linkEntity;

  const LinkCard({Key? key, this.linkEntity}) : super(key: key);

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  String mode = LinkCard.mode_info;
  bool istoggleOn = true;
  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case LinkCard.mode_edit:
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(49, 52, 57, 1)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      onClickAvatar();
                    },
                    child: Image.asset(
                      Utils.getImgPath("empty_pic"),
                      width: 48,
                      height: 48,
                    ),
                  ),
                  NuriSwitcher(
                    initialStatus: true,
                  )
                ],
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
                    cursorColor: UiColor.white,
                    style: UiTextStyles.n17(color: UiColor.white),
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
                    cursorColor: UiColor.white,
                    style: UiTextStyles.n17(color: UiColor.white),
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
                style: UiTextStyles.n11(color: UiColor.brandingGreen),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onClickRemove();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: UiColor.alertRed,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "删除",
                          style: UiTextStyles.n10(color: UiColor.alertRed),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      UiButton(
                        onClick: () {
                          onClickCancel();
                        },
                        textStyle: UiTextStyles.n12(color: UiColor.white),
                        borderRadius: 16,
                        buttonHeight: 32,
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
                        borderRadius: 16,
                        buttonHeight: 32,
                        buttonWidth: 56,
                        textColor: UiColor.black,
                        text: "保存",
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
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onClickEdit();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
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
                  Container(
                      child: NuriSwitcher(), margin: EdgeInsets.only(right: 16))
                ]),
          ),
        );

      default:
        return Container();
    }
  }

//----------Action ----------
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

  onClickRemove() {
    DialogUtils.showDialog(Get.context!, title: "确认删除已选链接？", actions: [
      DialogAction(
          title: "取消",
          action: () {
            Get.back();
          }),
      DialogAction(
          title: "删除",
          alert: true,
          action: () async {
            Get.back();
          })
    ]);
  }

  onClickAvatar() async {
    await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Center(
            child: CupertinoPopupSurface(
              child: Container(
                decoration: BoxDecoration(
                    color: UiColor.bottomSheetBkg,
                    borderRadius: BorderRadius.circular(8)),
                width: Get.width - 40,
                constraints: BoxConstraints(maxHeight: 350),
                padding: EdgeInsets.all(24),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "请选择 icon",
                        style: UiTextStyles.b17(color: UiColor.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          Utils.getImgPath("round_cross"),
                          width: 16,
                          height: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 40,
                              height: 40,
                              color: UiColor.white,
                              margin: EdgeInsets.all(4),
                            );
                          },
                          itemCount: 23)),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "从相册上传",
                          style: UiTextStyles.n14(color: UiColor.white),
                        ),
                        Image.asset(
                          Utils.getImgPath("arrow_right"),
                          width: 16,
                          height: 16,
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        },
        routeSettings: RouteSettings(name: "pick_icons"));
  }
}
