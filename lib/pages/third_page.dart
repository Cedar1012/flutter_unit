/// recommend_page.dart
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<ThirdPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('ThirdPage initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: Text('首页推荐: $count', style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
        ));
  }
}
