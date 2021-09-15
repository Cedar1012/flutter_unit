/// recommend_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/pages/element_dirty.dart';
import 'package:flutter_tabbar_state/pages/png_stack_shade_page.dart';
import 'package:flutter_tabbar_state/pages/thmem_page.dart';
import 'package:flutter_tabbar_state/widgets/align_animation.dart';
import 'package:flutter_tabbar_state/widgets/buttons.dart';
import 'package:flutter_tabbar_state/widgets/clipPath.dart';
import 'package:flutter_tabbar_state/widgets/cupertino_tab_scaffold.dart';
import 'package:flutter_tabbar_state/widgets/custom_painter.dart';
import 'package:flutter_tabbar_state/widgets/custom_scrollview.dart';
import 'package:flutter_tabbar_state/widgets/dialog.dart';
import 'package:flutter_tabbar_state/widgets/flex.dart';
import 'package:flutter_tabbar_state/widgets/flow.dart';
import 'package:flutter_tabbar_state/widgets/future_builder.dart';
import 'package:flutter_tabbar_state/widgets/gredview.dart';
import 'package:flutter_tabbar_state/widgets/listview.dart';
import 'package:flutter_tabbar_state/widgets/notification_listener.dart';
import 'package:flutter_tabbar_state/widgets/scffold_drawer.dart';
import 'package:flutter_tabbar_state/widgets/stream_builder.dart';
import 'package:flutter_tabbar_state/widgets/transform.dart';
import 'package:flutter_tabbar_state/widgets/utils.dart';

class WidgetsPage extends StatefulWidget {
  @override
  _WidgetsPageState createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _gridView() =>
      List.generate(50, (index) => Container(color: Utils.randomColor()));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List _listViewItem = [
      {
        'title': 'Flex 虚线',
        'router': 'flex',
        'page': FlexWidget(),
      },
      {
        'title': 'GridView',
        'router': 'gridview',
        'page': GridViewWidget(
          elementHeight: 100,
          elementWidth: 100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: _gridView(),
        )
      },
      {'title': 'Transform', 'router': 'transform', 'page': TransformWidget()},
      {
        'title': 'Scaffold Drawer',
        'router': 'scaffoldDrawer',
        'page': ScaffoldDrawerWidget()
      },
      {'title': 'Buttons', 'router': 'buttons', 'page': ButtonsWidget()},
      {'title': 'ListView', 'router': 'listview', 'page': ListViewWidget()},
      {
        'title': 'CustomScrollView',
        'router': 'customscrollbiew',
        'page': CustomScrollViewWidget()
      },
      {'title': 'Thmem', 'router': 'thmem', 'page': ThmemPage()},
      {
        'title': 'FutureBuilder',
        'router': 'futurebuilder',
        'page': FutureBuilderWidget()
      },
      {
        'title': 'StreamBuilder',
        'router': 'streambuilder',
        'page': StreamBuilderWidget()
      },
      {'title': 'Dialog', 'router': 'dialog', 'page': DialogPage()},
      {
        'title': '最小更新UI Element标记为dirty',
        'router': 'elementdirty',
        'page': ElementDirtyPage()
      },
      {
        'title': 'PNG 图片 Stack 增加阴影效果',
        'router': 'pngstackshade',
        'page': PngStackShadePage()
      },
      {'title': 'Flow', 'router': 'flow', 'page': FlowWidget()},
      {
        'title': 'Align + Animation',
        'router': 'alignAnimation',
        'page': AlignAnimationWidget()
      },
      {'title': 'ClipPath', 'router': 'clipPath', 'page': ClipPathWidget()},
      {
        'title': 'NotificationListener',
        'router': 'notificationListener',
        'page': NotificationListenerWidget()
      },
      {
        'title': 'CustomPainter',
        'router': 'customPainter',
        'page': CustomPainterWidget()
      },
      {
        'title': 'CupertinoTabScaffold',
        'router': 'cupertinoTabScaffold',
        'page': CupertinoTabScaffoldWidget()
      },
    ];
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _listViewItem.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            _listViewItem[index]['router'],
            arguments: _listViewItem[index]['page'],
          ),
          title: Text(_listViewItem[index]['title']),
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: index % 2 == 0 ? Colors.blue : Colors.green,
        ),
      ),
    );
  }
}
