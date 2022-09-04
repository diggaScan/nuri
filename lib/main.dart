import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuri/domain_layer/api_impl.dart';
import 'package:nuri/env_config.dart';
import 'package:nuri/page/routes/route_manager.dart';

void main() async {
  await initiateConfig();
  runApp(MyApp());
}

initiateConfig() async {
  var clientId = await EnvConfig.getClientId();
  ApiImpl().init(
      domain: "hechuan.moapi.dev.iln.cc/",
      sendTimeout: 5000,
      connectTimeout: 5000,
      receiveTimeout: 6000,
      clientId: clientId,
      version: "1.0.0");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'Nuri',
      defaultTransition: Transition.cupertino,
      initialRoute: AppRoutes.Web3Entry,
      supportedLocales: [const Locale('zh', 'CN'), const Locale('en', 'US')],
      theme: const CupertinoThemeData(
          barBackgroundColor: CupertinoColors.white,
          scaffoldBackgroundColor: CupertinoColors.white,
          primaryColor: Colors.redAccent,
          textTheme: CupertinoTextThemeData(
              primaryColor: Colors.green,
              navTitleTextStyle: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.w600,
                  height: 1.25),
              textStyle: TextStyle(
                  textBaseline: TextBaseline.ideographic,
                  fontSize: 17,
                  color: Colors.black,
                  height: 1.25))),
      debugShowCheckedModeBanner: false,
      getPages: RouteManager().init(),
    );
  }
}

