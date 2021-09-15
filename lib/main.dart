import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/home.dart';
import 'package:flutter_tabbar_state/models/theme.dart';
import 'package:flutter_tabbar_state/widgets/buttons.dart';
import 'package:flutter_tabbar_state/widgets/custom_scrollview.dart';
import 'package:flutter_tabbar_state/widgets/flex.dart';
import 'package:flutter_tabbar_state/widgets/listview.dart';
import 'package:flutter_tabbar_state/widgets/scffold_drawer.dart';
import 'package:flutter_tabbar_state/widgets/transform.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String, Widget Function(BuildContext)> routes = {
      '': (context) => MyHomePage(),
      'flex': (context) => FlexWidget(),
      'transform': (context) => TransformWidget(),
      'scaffoldDrawer': (context) => ScaffoldDrawerWidget(),
      'buttons': (context) => ButtonsWidget(),
      'listview': (context) => ListViewWidget(),
      'customscrollbiew': (context) => CustomScrollViewWidget(),
    };

    return Consumer<ThemeModel>(
      builder: (context, tm, child) => MaterialApp(
        theme: ThemeData(
          // Brightness brightness, //深色还是浅色
          // MaterialColor primarySwatch, //主题颜色样本，见下面介绍
          // Color primaryColor, //主色，决定导航栏颜色
          // Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
          // Color cardColor, //卡片颜色
          // Color dividerColor, //分割线颜色
          // ButtonThemeData buttonTheme, //按钮主题
          // Color cursorColor, //输入框光标颜色
          // Color dialogBackgroundColor,//对话框背景颜色
          // String fontFamily, //文字字体
          // TextTheme textTheme,// 字体主题，包括标题、body等文字样式
          // IconThemeData iconTheme, // Icon的默认样式
          // TargetPlatform platform, //指定平台，应用特定平台控件风格
          primarySwatch: tm.themeColor,
          iconTheme: IconThemeData(color: tm.themeColor),
          primaryColor: tm.themeColor,
          // backgroundColor: tm.themeColor,
        ),
        title: 'Flutter Study',
        onGenerateRoute: (RouteSettings settings) {
          print(settings.arguments);
          String routeName = settings.name;
          print('未找到路由:$routeName 将跳转${settings.arguments}');

          return settings.arguments != null
              ? MaterialPageRoute(builder: (context) {
                  return settings.arguments;
                })
              : null;
        },
        initialRoute: '',
        routes: routes,
        home: Builder(builder: (context) {
          print('000');
          print(MediaQuery.of(context).textScaleFactor);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: MyHomePage(),
          );
        }),
      ),
    );
  }
}
