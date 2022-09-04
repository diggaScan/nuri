import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/count_down_text.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/domain_layer/api_impl.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../components/border_textfield.dart';
import '../components/empty_page.dart';
import '../components/error_page.dart';
import '../components/loading_page.dart';
import '../components/toast.dart';
import '../infrastructure_layer/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final String domain;
  const LoginPage({Key? key,this.domain=''}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PageStatus {
  String accountNum = '';
  String verificationCode = '';

  ///---------- 页面生命周期回调 ----------
  @override
  void initState() {
    super.initState();

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
              child: Text("登录 序.",
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
              onClickEnterEditPage();
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
          height: 380 / 812 * Get.height,
        ),
        Center(
          child: ClickToLogin(
            content: "点击注册",
            onTap: () {
              onClickRegistar();
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

//发送验证码
  onClickSendVerificationCode() {
    //发送验证码
    //ApiImpl().getVerifyCode(account: accountNum, countryCode: "86", type: 3);
    NuriToast.show("验证码已发送");
  }

  onClickEnterEditPage() {
     if (accountNum.isEmpty) {
        NuriToast.show("请输入手机号码");
        return;
      }
      if (verificationCode.isEmpty) {
        NuriToast.show("请输入验证码");
        return;
      }
    //Api 登录
    Get.toNamed(AppRoutes.editYourLand);
  }

  onClickRegistar() {
    Get.toNamed("${AppRoutes.registar}?domain=${widget.domain}");
  }
}
