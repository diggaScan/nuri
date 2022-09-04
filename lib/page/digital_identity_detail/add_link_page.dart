import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuri/components/clikc_to_login.dart';
import 'package:nuri/components/ui_button.dart';
import 'package:nuri/page/digital_identity_detail/link_card.dart';
import 'package:nuri/page/registar_page.dart';
import 'package:nuri/page/page_meta/page_status.dart';
import 'package:nuri/page/routes/route_manager.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';
import 'package:nuri/view_model_layer/vm_add_link_page.dart';

import '../../components/empty_page.dart';
import '../../components/error_page.dart';
import '../../components/loading_page.dart';
import '../../infrastructure_layer/utils/utils.dart';

class AddLinkPage extends StatefulWidget {
  const AddLinkPage({Key? key}) : super(key: key);

  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> with PageStatus {
  VmAddLinkPage _vmAddLinkPage = VmAddLinkPage();

  ///---------- 页面生命周期回调 ---------
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
    _vmAddLinkPage.getLinkItem();
    refreshPage();
  }

  ///---------- 页面View ----------

  body() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          color: UiColor.black,
          child: Column(children: [
            SizedBox(
              height: 24,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              color: UiColor.grey4,
              radius: Radius.circular(8),
              padding: EdgeInsets.all(6),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  width: Get.width,
                  child: Text(
                    "添加链接",
                    style: UiTextStyles.b15(color: UiColor.grey3),
                  ),
                ),
                onTap: () {
                  onClickAddLink();
                },
              ),
            ),
            SizedBox(height: 16,),
            Obx((){
              return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 16,width: Get.width,);
              },
              itemBuilder: (BuildContext context, int index) {
                return LinkCard();
              },
              itemCount: _vmAddLinkPage.linkEntities.value.length,
            );
            })
            
          ]),
        ));
  }

  ///---------- 页面交互 ----------
  refreshPage() {
    setState(() {
      pageState = PageState.success;
    });
  }

  onClickAddLink() {
    _vmAddLinkPage.addNewLink();
  }
}
