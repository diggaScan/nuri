import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/domain_layer/api_impl.dart';
import 'package:nuri/page/digital_identity_detail/add_link_page.dart';
import 'package:nuri/page/registar_page.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

import '../../components/empty_page.dart';
import '../../components/error_page.dart';
import '../../components/loading_page.dart';
import '../../infrastructure_layer/utils/utils.dart';

class EditYourLand extends StatefulWidget {
  final String domain;
  const EditYourLand({Key? key, this.domain = ''}) : super(key: key);

  @override
  _EditYourLandState createState() => _EditYourLandState();
}

class _EditYourLandState extends State<EditYourLand>
    with PageStatus, TickerProviderStateMixin {
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          color: UiColor.black,
          home: Scaffold(
            backgroundColor: UiColor.black,
            body: body(),
          ),
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
    return NestedScrollView(
        headerSliverBuilder: (context, bol) {
          return [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: buildTop(),
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverTabBarDelegate(
                buildTab(),
                color: Colors.black,
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: TabController(length: 2, vsync: this),
          children: buildTabPage(),
        ));
  }

  buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onClickAvatar(context);
              },
              child: Image.asset(
                Utils.getImgPath("no_avatar_icon"),
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Melly",
                  style: UiTextStyles.b24(color: UiColor.white),
                ),
                Text(
                  "nuri.page/melly",
                  style: UiTextStyles.n17(color: UiColor.grey4),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onClickPreview();
              },
              child: Image.asset(
                Utils.getImgPath("hide_icon"),
                width: 20,
                height: 20,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                onClickShare();
              },
              child: Image.asset(
                Utils.getImgPath("share_icon"),
                width: 20,
                height: 20,
              ),
            ),
          ],
        )
      ],
    );
  }

  buildTab() {
    List<Widget> tabs = [];
    tabs.add(Tab(
        child: Container(
      height: 64,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: 20,
        right: 12,
      ),
      child: Text(
        '社交账号',
        overflow: TextOverflow.ellipsis,
      ),
    )));
    tabs.add(Tab(
        child: Container(
      height: 64,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: Text(
        '基础信息',
        overflow: TextOverflow.ellipsis,
      ),
    )));

    return TabBar(
      controller: TabController(length: 2, vsync: this),
      labelPadding: EdgeInsets.all(0),
      onTap: (value) {},
      tabs: tabs,
      isScrollable: true,
      labelColor: UiColor.brandingGreen,
      labelStyle: UiTextStyles.b17(color: UiColor.white),
      unselectedLabelColor: UiColor.grey3,
      unselectedLabelStyle: UiTextStyles.b17(color: UiColor.grey3),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 0,
      indicator: UnderlineTabIndicator(
          insets: EdgeInsets.symmetric(horizontal: 20),
          borderSide: BorderSide(
              width: 2,
              color: UiColor.brandingGreen,
              style: BorderStyle.solid)),
    );
  }

  buildTabPage() {
    List<Widget> pages = [];
    for (int i = 0; i < 2; i++) {
      pages.add(Container(
        child: AddLinkPage(),
        margin: EdgeInsets.symmetric(horizontal: 20),
      ));
    }
    return pages;
  }

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }

  onClickAvatar(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 184,
            color: UiColor.bottomSheetBkg,
            width: Get.width,
            child: Column(children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                          height: 55.5,
                          alignment: Alignment.center,
                          child: Text(
                            "上传头像",
                            style: UiTextStyles.n17(
                              color: UiColor.white,
                            ),
                          ));
                    } else if (index == 1) {
                      return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            onClickLogOut();
                          },
                          child: Container(
                              height: 55.5,
                              alignment: Alignment.center,
                              child: Text(
                                "退出账号",
                                style: UiTextStyles.n17(
                                  color: UiColor.alertRed,
                                ),
                              )));
                    } else if (index == 2) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 72,
                            alignment: Alignment.center,
                            child: Text(
                              "取消",
                              style: UiTextStyles.n17(
                                color: UiColor.grey4,
                              ),
                            )),
                      );
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: UiColor.grey2,
                    );
                  },
                  itemCount: 3)
            ]),
          );
        });
  }

  onClickPreview() {
    Get.toNamed(AppRoutes.yourLand);
  }

//分享
  onClickShare() {}

  onClickLogOut() {
    //api 推出登录
    // ApiImpl().logout();
    Get.offAndToNamed(AppRoutes.Web3Entry);
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color? color;

  const SliverTabBarDelegate(this.widget, {this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
