/// recommend_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/painting/paint.dart';
import 'package:flutter_tabbar_state/painting/paper.dart';

class PaintingPage extends StatefulWidget {
  @override
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List _listViewItem = [
      {'title': 'Paper', 'router': 'Paper', 'page': Paper()},
      {'title': 'Paint', 'router': 'paint', 'page': PaintPage()},
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Painting')),
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
