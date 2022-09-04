import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:nuri/page/digital_identity_detail/edit_your_land.dart';
import 'package:nuri/page/registar_page.dart';
import 'package:nuri/page/login_page.dart';
import 'package:nuri/page/web3_entry_page.dart';

class AppRoutes {
  //主页面
  static const Web3Entry = '/home'; //创建域名页面
  static const registar = '/registar'; //注册页面
  static const login = '/login'; //登录页面
  static const editYourLand = '/editYourLand'; //个人信息编辑页面
}

class RouteManager {
  List<GetPage>? pages;

  static RouteManager? _instance;
  RouteManager._internal();

  factory RouteManager() {
    return _instance ??= RouteManager._internal();
  }

  void addPages(GetPage page) {
    pages ??= [];
    pages!.add(page);
  }

  List<GetPage> init() {
    addPages(GetPage(
        name: AppRoutes.Web3Entry,
        page: () {
          return Web3EntryPage();
        }));

    addPages(GetPage(
        name: AppRoutes.login,
        page: () {
          String domain = getParameterString("domain", defaultValue: "");
          return LoginPage(
            domain: domain,
          );
        }));
    addPages(GetPage(
        name: AppRoutes.editYourLand,
        page: () {
          return EditYourLand();
        }));

    addPages(GetPage(
        name: AppRoutes.registar,
        page: () {
          String domain = getParameterString("domain", defaultValue: "");
          return RegistarPage(
            domain: domain,
          );
        }));
    return pages ?? [];
  }

  int getParameterInt(String key, {int defaultValue = 0}) {
    var value = Get.parameters[key];
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  String getParameterString(String key, {String defaultValue = ''}) {
    var value = Get.parameters[key];
    if (value == null || value.isEmpty) return defaultValue;
    return value;
  }
}
