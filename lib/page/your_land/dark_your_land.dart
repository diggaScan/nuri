import 'package:flutter/material.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';
import '../../components/empty_page.dart';
import '../../components/error_page.dart';
import '../../components/loading_page.dart';
import '../../infrastructure_layer/utils/utils.dart';

class DarkYourLand extends StatefulWidget {
  final String domain;
  const DarkYourLand({Key? key, this.domain = ''}) : super(key: key);

  @override
  _DarkYourLandState createState() => _DarkYourLandState();
}

class _DarkYourLandState extends State<DarkYourLand>
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

  body() {}

  buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                
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
                // onClickPreview();
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
                // onClickShare();
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

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }
}
