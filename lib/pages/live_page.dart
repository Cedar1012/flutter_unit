/// recommend_page.dart
import 'package:flutter/material.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('LivePage initState');
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
