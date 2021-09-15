/// recommend_page.dart
import 'package:flutter/material.dart';

class VipPage extends StatefulWidget {
  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('VipPage initState');
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
