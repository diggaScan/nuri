import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../components/border_textfield.dart';
import '../components/empty_page.dart';
import '../components/error_page.dart';
import '../components/loading_page.dart';
import '../infrastructure_layer/utils/utils.dart';

class LoginPage extends StatefulWidget {
  static const mode_binding = "mode_binding";
  static const mode_login = "mode_login";
  final String? mode;
  const LoginPage({Key? key, this.mode = LoginPage.mode_binding})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PageStatus {
  late TextEditingController _mobileNumberController;
  late TextEditingController _verifyCodeodeController;

  ///---------- 页面生命周期回调 ----------
  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController();
    _verifyCodeodeController = TextEditingController();
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 92,
                    ),
                    widget.mode == LoginPage.mode_binding
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "你的主页链接创建成功啦！",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 199, 251, 80),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "https://nuri.page/melly",
                                style: UiTextStyles.n17(
                                    color: UiColor.brandingGreen),
                              ),
                              SizedBox(
                                height: 48,
                              ),
                              Text(
                                "请关联你的手机号",
                                style: UiTextStyles.b24(color: UiColor.white),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                            ],
                          )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "登录 Nuri.",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 199, 251, 80),
                                ),
                              ),
                              SizedBox(
                                height: 48,
                              ),
                            ],
                          ),
                    Container(
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
                              child: TextField(
                                maxLines: 1,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(11) // 限制长度
                                ],
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
                                cursorRadius: Radius.circular(0),
                                cursorColor: UiColor.brandingGreen,
                                style: UiTextStyles.n17(
                                    color: UiColor.brandingGreen),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "手机号",
                                  hintStyle:
                                      UiTextStyles.n17(color: UiColor.grey3),
                                ),
                              ),
                            ),
                            Text(
                              "获取验证码",
                              style: UiTextStyles.n14(color: UiColor.white),
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
                              child: TextField(
                                maxLines: 1,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(4) // 限制长度
                                ],
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
                                cursorRadius: Radius.circular(0),
                                cursorColor: UiColor.brandingGreen,
                                style: UiTextStyles.n17(
                                    color: UiColor.brandingGreen),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "验证码",
                                  hintStyle:
                                      UiTextStyles.n17(color: UiColor.grey3),
                                ),
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
                      child: UiButton(
                        onClick: () {
                          onClickEnterNuri();
                        },
                        buttonHeight: 48,
                        buttonWidth: Get.width,
                        textColor: UiColor.black,
                        text: "进入 Nuri.",
                        buttonColor: UiColor.white,
                      ),
                    ),
                  ],
                )),
                Center(
                  child: ClickToLogin(
                    onTap: () {
                      onClickLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: 48,
                )
              ],
            ),
          ),
        ));
  }

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }
    onClickLogin() {
    Get.toNamed("${AppRoutes.login}?mode=${LoginPage.mode_login}");
  }

  onClickEnterNuri(){
    Get.toNamed("${AppRoutes.digitalIdentityDetailPage}");

  }
}
