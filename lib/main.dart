import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuri/page/routes/route_manager.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(child: MyApp()),
  ));
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
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      getPages: RouteManager().init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
