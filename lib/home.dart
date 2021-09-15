/// home.dart
import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/painting_page.dart';

import './pages/first_page.dart';
import './pages/third_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bodyList = [FirstPage(), PaintingPage(), ThirdPage()];

  final pageController = PageController();

  void onTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  _child() {
    print('222');
    return bodyList;
  }

  @override
  Widget build(BuildContext context) {
    print('11111');
    return Scaffold(
      bottomNavigationBar: UnitBottomBar(onTap: onTap),
      body: PageView(
        controller: pageController,
        children: _child(),
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
    );
  }
}

class UnitBottomBar extends StatefulWidget {
  final Function onTap;
  const UnitBottomBar({this.onTap});
  _UnitBottomBarState createState() => _UnitBottomBarState();
}

class _UnitBottomBarState extends State<UnitBottomBar> {
  int currentIndex = 0;
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.format_paint), label: 'Painting'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的')
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
