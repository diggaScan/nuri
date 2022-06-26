import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/page/logn_in_page.dart';
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
            color: Colors.black,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 349,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Nuri. ",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 199, 251, 80),
                                ),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "创建你的个人品牌主页",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 199, 251, 80),
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
                                    style:
                                        UiTextStyles.n17(color: UiColor.white),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      maxLines: 1,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(
                                            20) // 限制长度
                                      ],
                                      textAlign: TextAlign.left,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: TextEditingController(),
                                      cursorRadius: Radius.circular(0),
                                      cursorColor: UiColor.brandingGreen,
                                      style: UiTextStyles.n17(
                                          color: UiColor.brandingGreen),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "请输入你的域名",
                                        hintStyle: UiTextStyles.n17(
                                            color: UiColor.grey3),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    Utils.getImgPath("check_circle"),
                                    width: 24,
                                    height: 24,
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
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: UiButton(
                              onClick: () {
                               onClickEnterNuri();
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
                    )
                  ],
                ),
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
    Get.toNamed("${AppRoutes.login}?mode=${LoginPage.mode_binding}");

  }
}
