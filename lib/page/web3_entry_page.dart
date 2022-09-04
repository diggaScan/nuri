import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/domain_layer/bp_logic_check.dart';
import 'package:nuri/common/special_function.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/domain_layer/api_impl.dart';
import 'package:nuri/page/registar_page.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../components/empty_page.dart';
import '../components/error_page.dart';
import '../components/loading_page.dart';
import '../infrastructure_layer/utils/utils.dart';

class Web3EntryPage extends StatefulWidget {
  const Web3EntryPage({Key? key}) : super(key: key);

  @override
  _Web3EntryPageState createState() => _Web3EntryPageState();
}

class _Web3EntryPageState extends State<Web3EntryPage> with PageStatus {
  RxString doaminErrorTip = ''.obs;
  RxInt showQualifiedIcon = (-1).obs; //-1未校验, 1 正确  2 错误
  String domain = '';

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
          resizeToAvoidBottomInset: true,
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
      child: Container(
        color: UiColor.black,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 349 / 812 * Get.height,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "序. ",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: UiColor.brandingGreen,
                          ),
                        )),
                    SizedBox(
                      height: 16,
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
                          child: Text(
                            "创建你的个人品牌主页",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 48,
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
                                controller: TextEditingController(),
                                onChanged: (value) {
                                  SpecFunction().xuDebounce(() {
                                    domain = value;
                                    BpLogicCheck.isDomainValid(domain,
                                        whenDomainEmpty: () {
                                      doaminErrorTip.value = "";
                                      showQualifiedIcon.value = -1;
                                    }, whenDomainUnvalid: () {
                                      doaminErrorTip.value =
                                          "请输入域名，仅支持英文字母,数字和下划线";
                                      showQualifiedIcon.value = 2;
                                    }, whenDomainValid: () {
                                      doaminErrorTip.value = "";
                                      showQualifiedIcon.value = 1;
                                    });
                                  });
                                },
                                cursorRadius: Radius.circular(0),
                                cursorColor: UiColor.brandingGreen,
                                style: UiTextStyles.n17(
                                    color: UiColor.brandingGreen),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(49, 52, 57, 1)),
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
                            margin:
                                EdgeInsets.only(top: 4, bottom: 16, left: 20),
                            child: Text(
                              doaminErrorTip.value,
                              style: UiTextStyles.n11(color: UiColor.alertRed),
                            ));
                      }
                    }),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: UiButton(
                        onClick: () {
                          if (domain.isEmpty) {
                            doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
                            return;
                          }
                          BpLogicCheck.isDomainValid(domain,
                              whenDomainEmpty: () {
                            doaminErrorTip.value = "";
                            showQualifiedIcon.value = -1;
                          }, whenDomainUnvalid: () {
                            doaminErrorTip.value = "请输入域名，仅支持英文字母,数字和下划线";
                            showQualifiedIcon.value = 2;
                          }, whenDomainValid: () {
                            doaminErrorTip.value = "";
                            showQualifiedIcon.value = 1;

                            //进行抢占
                            // ApiImpl().registerName(nickName: domain);
                            if (true) {
                              onClickRegistar();
                            } else {
                              doaminErrorTip.value = "域名已被使用，请重新输入";
                              showQualifiedIcon.value = 2;
                            }
                          });
                        },
                        buttonHeight: 48,
                        buttonWidth: Get.width,
                        borderRadius: 8,
                        textColor: UiColor.black,
                        text: "极速创建",
                        buttonColor: UiColor.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 112 / 812 * Get.height,
                ),
                Center(
                  child: ClickToLogin(
                    onTap: () {
                      onClickLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }

  onClickLogin() {
    Get.toNamed("${AppRoutes.login}");
  }

  onClickRegistar() {
    Get.toNamed("${AppRoutes.registar}?domain=$domain");
  }
}
