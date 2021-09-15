import 'package:flutter/material.dart';

class FutureBuilderWidget extends StatefulWidget {
  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  Future loadData;
  @override
  void initState() {
    super.initState();
    loadData = mocNetworkData();
  }

  Future mocNetworkData() async {
    return Future.delayed(
        Duration(seconds: 3), () => '我是通过BuilderFuture获取的互联网数据');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder'),
      ),
      body: Align(
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: loadData,
              initialData: '-------',
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Text("错误: ${snapshot.error}");
                  else
                    return Text("成功: ${snapshot.data}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                loadData = mocNetworkData();
                setState(() {});
              },
              child: Text('重新加载'),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
