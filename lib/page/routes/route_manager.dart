import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:nuri/page/digital_identity_detail/digital_identity_detail.dart';
import 'package:nuri/page/logn_in_page.dart';
import 'package:nuri/page/web3_entry_page.dart';

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
          String mode = getParameterString("mode");
          return LoginPage(
            mode: mode,
          );
        }));
    addPages(GetPage(
        name: AppRoutes.digitalIdentityDetailPage,
        page: () {
          return DigitalIdentityDetailPage();
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

class AppRoutes {
  //主页面
  static const Web3Entry = '/home';
  static const login = '/login';
  static const digitalIdentityDetailPage = '/digitalIdentityDetailPage';
}
