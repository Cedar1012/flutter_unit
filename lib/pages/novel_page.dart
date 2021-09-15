/// recommend_page.dart
import 'package:flutter/material.dart';

class NovelPage extends StatefulWidget {
  @override
  _NovelPageState createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('NovelPage initState');
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
