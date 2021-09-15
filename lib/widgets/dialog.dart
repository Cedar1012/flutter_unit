import 'dart:math';

import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  String _text = '此处显示点击结果';

  Future _sh(Widget dialog) => showDialog(
        context: context,
        builder: (BuildContext buildContext) => dialog,
      );

  Color randomColor() => Color.fromARGB(
        255,
        Random().nextInt(256) + 0,
        Random().nextInt(256) + 0,
        Random().nextInt(256) + 0,
      );

  Widget outLineBtn(String text) => Builder(
        builder: (context) => OutlineButton(
          textColor: randomColor(),
          highlightColor: randomColor(),
          focusColor: randomColor(),
          hoverColor: randomColor(),
          highlightedBorderColor: randomColor(),
          splashColor: randomColor(),
          disabledTextColor: randomColor(),
          disabledBorderColor: randomColor(),
          shape: Border.all(color: randomColor()),
          borderSide: BorderSide(color: randomColor()),
          color: randomColor(),
          onPressed: () async {
            int result = await _sh(_switch(text));
            _text = result.toString();
            setState(() {});
          },
          child: Text(text),
        ),
      );

  Widget _alertDialog() => AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(0), //关闭对话框
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // ... 执行删除操作
              Navigator.of(context).pop(1); //关闭对话框
            },
          ),
        ],
      );

  Widget _simpleDialog() => SimpleDialog(
        title: const Text('请选择语言'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              // 返回1
              Navigator.pop(context, 1);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: const Text('中文简体'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              // 返回2
              Navigator.pop(context, 2);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: const Text('美国英语'),
            ),
          ),
        ],
      );

  Widget _dialog() => Dialog(
        child: Column(
          children: [
            ListTile(title: Text("请选择")),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text('$index'),
                  onTap: () => Navigator.of(context).pop(index),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _unconstrainedBox() => UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 120,
            maxWidth: 280,
            maxHeight: 200,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );

  bool withTree = false;

  Widget _alertDialogCheckBox() => AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                Checkbox(
                  value: withTree,
                  onChanged: (bool value) {
                    //复选框选中状态发生变化时重新构建UI
                    // setState(() {
                    //更新复选框状态
                    (context as Element).markNeedsBuild();
                    withTree = !withTree;
                    // });
                  },
                ),
                // StatefulBuilder(
                //   builder: (context, _ss) => Checkbox(
                //     value: withTree,
                //     onChanged: (bool value) {
                //       //复选框选中状态发生变化时重新构建UI
                //       _ss(() {
                //         //更新复选框状态
                //         withTree = !withTree;
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(0),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              //执行删除操作
              Navigator.of(context).pop(withTree ? 1 : 0);
            },
          ),
        ],
      );

  Widget _switch(String text) {
    switch (text) {
      case 'AlertDialog':
        return _alertDialog();
        break;
      case 'SimpleDialog':
        return _simpleDialog();
        break;
      case 'Dialog':
        return _dialog();
        break;
      case 'UnconstrainedBox':
        return _unconstrainedBox();
        break;
      case 'AlertDialogCheckBox':
        return _alertDialogCheckBox();
        break;
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: Align(
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '点击了:$_text',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 40,
              ),
            ),
            outLineBtn('AlertDialog'),
            outLineBtn('SimpleDialog'),
            outLineBtn('Dialog'),
            outLineBtn('UnconstrainedBox'),
            outLineBtn('AlertDialogCheckBox'),
          ],
        ),
      ),
    );
  }
}
