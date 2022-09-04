import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/domain_layer/api_impl.dart';
import 'package:nuri/domain_layer/bp_logic_check.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../common/special_function.dart';
import '../components/border_textfield.dart';
import '../components/count_down_text.dart';
import '../components/empty_page.dart';
import '../components/error_page.dart';
import '../components/loading_page.dart';
import '../components/toast.dart';
import '../infrastructure_layer/utils/utils.dart';

class RegistarPage extends StatefulWidget {
  final String domain;
  const RegistarPage({Key? key, this.domain = ''}) : super(key: key);

  @override
  _RegistarPageState createState() => _RegistarPageState();
}

class _RegistarPageState extends State<RegistarPage> with PageStatus {
  String accountNum = '';
  String verificationCode = '';
  RxString doaminErrorTip = ''.obs;
  RxInt showQualifiedIcon = (-1).obs; //-1未校验, 1 正确  2 错误
  String domain = '';
  late TextEditingController domainTextController;

  ///---------- 页面生命周期回调 ----------
  @override
  void initState() {
    super.initState();
    domain = widget.domain;
    domainTextController = TextEditingController(text: widget.domain);
    //获取数据模型

    //初始页面状态
    pageState = PageState.loading;
    //获取传参的数据模型
    getData();
  }

  @override
  Widget build(BuildContext context) {
    switch (pageState) {
      case PageState.success:
        return Scaffold(
          backgroundColor: UiColor.black,
          body: body(),
        );
      case PageState.loading:
        return const LoadingPage();
      case PageState.error:
        return ErrorPage(
          title: "诶呀,没联系上服务器",
          showButton: true,
          callback: () {
            getData();
          },
        );
      case PageState.idle:
      case PageState.empty:
        return const EmptyPage();
    }

    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///---------- 页面数据逻辑 ----------
  getData() {
    refreshPage();
  }

  ///---------- 页面View ----------

  body() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 92 / 812 * Get.height,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                    begin: Alignment(-0.03, -1.0),
                    end: Alignment(0, 1.0),
                    colors: [
                      Color.fromRGBO(199, 251, 80, 1),
                      Color.fromRGBO(205, 249, 91, 1),
                      Color.fromRGBO(239, 237, 151, 1),
                      Color.fromRGBO(208, 172, 243, 1),
                      Color.fromRGBO(196, 66, 165, 1)
                    ],
                    stops: [
                      0.1,
                      0.3,
                      0.56,
                      0.78,
                      1.0
                    ]).createShader(Offset.zero & bounds.size);
              },
              child: Text("注册 序.",
                  style: TextStyle(
                      fontSize: 40,
                      height: 48.1 / 40,
                      fontWeight: FontWeight.w900,
                      color: UiColor.white)),
            )),
        SizedBox(
          height: 48 / 812 * Get.height,
        ),
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
                    controller: domainTextController,
                    onChanged: (value) {
                      SpecFunction().xuDebounce(() {
                        domain = value;

                        BpLogicCheck.isDomainValid(domain, whenDomainEmpty: () {
                          doaminErrorTip.value = "";
                          showQualifiedIcon.value = -1;
                        }, whenDomainUnvalid: () {
                          doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
                          showQualifiedIcon.value = 2;
                        }, whenDomainValid: () {
                          doaminErrorTip.value = "";
                          showQualifiedIcon.value = 1;
                        });
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
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Container(
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
                Expanded(
                  child: CupertinoTextField(
                    maxLines: 1,
                    onChanged: (value) {
                      accountNum = value;
                    },
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(11), // 限制长度
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.left,
                    placeholder: "手机号",
                    keyboardType: TextInputType.number,
                    placeholderStyle: UiTextStyles.n17(color: UiColor.grey3),
                    textAlignVertical: TextAlignVertical.center,
                    controller: TextEditingController(),
                    cursorRadius: Radius.circular(0),
                    cursorColor: UiColor.brandingGreen,
                    style: UiTextStyles.n17(color: UiColor.brandingGreen),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(49, 52, 57, 1)),
                  ),
                ),
                VerifyCodeCountDownText(
                  time: 60,
                  getContent: (count) {
                    return "${count}s后可重新发送";
                  },
                  onEffectiveClick: () {
                    onClickSendVerificationCode();
                  },
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Container(
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
                Expanded(
                  child: CupertinoTextField(
                    maxLines: 1,
                    onChanged: (value) {
                      verificationCode = value;
                    },
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(4), // 限制长度
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    placeholder: "验证码",
                    placeholderStyle: UiTextStyles.n17(color: UiColor.grey3),
                    controller: TextEditingController(),
                    cursorRadius: Radius.circular(0),
                    cursorColor: UiColor.brandingGreen,
                    style: UiTextStyles.n17(color: UiColor.brandingGreen),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(49, 52, 57, 1)),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: UiButton(
            onClick: () {
              onClickEnterNuri(domain);
            },
            buttonHeight: 48,
            buttonWidth: Get.width,
            borderRadius: 8,
            textColor: UiColor.black,
            text: "进入 序.",
            buttonColor: UiColor.white,
          ),
        ),
        SizedBox(
          height: 320 / 812 * Get.height,
        ),
        Center(
          child: ClickToLogin(
            onTap: () {
              onClickLogin();
            },
          ),
        ),
      ]),
    );
  }

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }

  onClickLogin() {
    Get.toNamed("${AppRoutes.login}?domain=$domain");
  }

  onClickEnterNuri(String domain) {
    if (domain.isEmpty) {
      doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
      return;
    }
    BpLogicCheck.isDomainValid(domain, whenDomainEmpty: () {
      doaminErrorTip.value = "";
      showQualifiedIcon.value = -1;
    }, whenDomainUnvalid: () {
      doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
      showQualifiedIcon.value = 2;
    }, whenDomainValid: () {
      doaminErrorTip.value = "";
      showQualifiedIcon.value = 1;
      if (accountNum.isEmpty) {
        NuriToast.show("请输入手机号码");
        return;
      }
      if (verificationCode.isEmpty) {
        NuriToast.show("请输入验证码");
        return;
      }
      //api 进行抢占,注册
      // ApiImpl().registerName(nickName: domain);
      //ApiImpl().accountRegister(accountName: accountName, verify: verify, repeat: repeat, nickName: nickName, key: key, type: type)
      if (true) {
        Get.toNamed(AppRoutes.editYourLand);
      } else {
        doaminErrorTip.value = "域名已被使用，请重新输入";
        showQualifiedIcon.value = 2;
      }
    });
  }

  //发送验证码
  onClickSendVerificationCode() {
    //发送验证码
    //ApiImpl().getVerifyCode(account: accountNum, countryCode: "86", type: 3);
    NuriToast.show("验证码已发送");
  }
}
