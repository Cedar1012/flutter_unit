import 'package:flutter/material.dart';

class StreamBuilderWidget extends StatefulWidget {
  @override
  _StreamBuilderWidgetState createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  Stream countFun;
  @override
  void initState() {
    super.initState();
    countFun = counter();
  }

  Stream<int> counter() => Stream.periodic(Duration(milliseconds: 10),
      (i) => i > 200 ? throw new Exception('超过200 显示Stream错误信息') : i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder'),
      ),
      body: Align(
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: countFun,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError)
                  return Column(
                    children: [
                      Text('错误:${snapshot.error}'),
                      SizedBox(height: 30),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            countFun = counter();
                          });
                        },
                        child: Text('重置'),
                      ),
                    ],
                  );
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('没有Stream');
                    break;
                  case ConnectionState.waiting:
                    return Text('等待数据...');
                    break;
                  case ConnectionState.active:
                    return Column(children: [
                      Text('active:${snapshot.data}'),
                      SizedBox(height: 30),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        minWidth: 150.0 + snapshot.data,
                        onPressed: () {
                          setState(() {
                            countFun = counter();
                          });
                        },
                        child: Text('重置 minWidth:${300.0 + snapshot.data}'),
                      ),
                    ]);

                    break;
                  case ConnectionState.done:
                    return Text('数据关闭');
                    break;
                  default:
                    return null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
