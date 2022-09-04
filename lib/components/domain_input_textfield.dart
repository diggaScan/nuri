import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common/special_function.dart';
import '../infrastructure_layer/utils/utils.dart';
import '../ui_theme/ui_color.dart';
import '../ui_theme/ui_text_style.dart';

class DomainInputTextfield extends StatefulWidget {
  const DomainInputTextfield({Key? key}) : super(key: key);

  @override
  State<DomainInputTextfield> createState() => _DomainInputTextfieldState();
}

class _DomainInputTextfieldState extends State<DomainInputTextfield> {
  RxString doaminErrorTip = ''.obs;
  RxInt showQualifiedIcon = (-1).obs; //-1未校验, 1 正确  2 错误
  String domain = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: Get.width,
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(49, 52, 57, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Nuri.page/",
                  style: UiTextStyles.n17(color: UiColor.white),
                ),
                Expanded(
                  child: CupertinoTextField(
                    maxLines: 1,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20) // 限制长度
                    ],
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    controller: TextEditingController(),
                    onChanged: (value) {
                      SpecFunction().xuDebounce(() {
                        domain = value;
                        qualifyDomainFormat(domain);
                      });
                    },
                    cursorRadius: Radius.circular(0),
                    cursorColor: UiColor.brandingGreen,
                    style: UiTextStyles.n17(color: UiColor.brandingGreen),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(49, 52, 57, 1)),
                  ),
                ),
                Obx(() {
                  if (showQualifiedIcon.value == 1) {
                    return Image.asset(
                      Utils.getImgPath("check_circle"),
                      width: 24,
                      height: 24,
                    );
                  } else if (showQualifiedIcon.value == 2) {
                    return Image.asset(
                      Utils.getImgPath("cross_icon_red_bkg"),
                      width: 24,
                      height: 24,
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (doaminErrorTip.value.isEmpty) {
            return SizedBox(
              height: 24,
            );
          } else {
            return Container(
                margin: EdgeInsets.only(top: 4, bottom: 16, left: 20),
                child: Text(
                  doaminErrorTip.value,
                  style: UiTextStyles.n11(color: UiColor.alertRed),
                ));
          }
        }),
      ]),
    );
  }

  //校验用户域名的有效性
  bool qualifyDomainFormat(String content) {
    if (content.isEmpty) {
      doaminErrorTip.value = "";
      showQualifiedIcon.value = -1;
      return false;
    }

    RegExp pattern = RegExp(r'^[a-zA-Z0-9_]+$');
    bool allQualifiedChar = pattern.hasMatch(content);
    if (!allQualifiedChar) {
      doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
      showQualifiedIcon.value = 2;
      return false;
    } else {
      doaminErrorTip.value = "";
      showQualifiedIcon.value = 1;
      return true;
    }
  }
}
