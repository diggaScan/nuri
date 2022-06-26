import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:nuri/infrastructure_layer/dispatcher/diapatcher.dart';
import 'package:nuri/infrastructure_layer/dispatcher/event.dart';
import 'package:nuri/view_model_layer/data/link_etity.dart';



class VmAddLinkPage extends GetxController {
  VmAddLinkPage._();

  factory VmAddLinkPage() {
    VmAddLinkPage vmAddLinkPage;
    if (Get.isPrepared<VmAddLinkPage>()) {
      vmAddLinkPage = Get.find<VmAddLinkPage>();
    } else {
      vmAddLinkPage = Get.put(VmAddLinkPage._());
    }
    return vmAddLinkPage;
  }

  /// -------- UI 数据 ------------
  //UI 数据
  StreamSubscription? refreshSubscription;
  RxList<LinkEntity> linkEntities=<LinkEntity>[].obs;

  /// -------- VM lifecycle ---------

  @override
  void onInit() {
    //订阅eventbus
    refreshSubscription = Dispatcher().eventBus.on<RefreshEvent>().listen((event) {
      
    });
    super.onInit();
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }

  //清除缓存数据
  clearData() {}

  ///------------- Action --------------
  getLinkItem(){
    linkEntities.add(LinkEntity());
  }

  addNewLink(){
        linkEntities.add(LinkEntity());

  }

  ///-------------- 其它数据处理 ---------------


}
