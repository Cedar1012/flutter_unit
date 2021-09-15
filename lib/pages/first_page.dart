/// first_page.dart
import 'package:flutter/material.dart';

import 'live_page.dart';
import 'novel_page.dart';
import 'vip_page.dart';
import 'widgets_page.dart';

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('Widgets'), body: WidgetsPage()),
  _TabData(tab: Text('其他1'), body: VipPage()),
  _TabData(tab: Text('其他2'), body: NovelPage()),
  _TabData(tab: Text('其他3'), body: LivePage())
];

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarList.length,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontSize: 18),
              labelColor: Colors.red,
              labelStyle: TextStyle(fontSize: 20),
              tabs: tabBarList,
            ),
          ),
          Expanded(
              child: TabBarView(
            children: tabBarViewList,
            // physics: NeverScrollableScrollPhysics(), // 禁止滑动
          ))
        ],
      ),
    );
  }
}
