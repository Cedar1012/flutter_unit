import 'package:flutter/material.dart';

class ElementDirtyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> showDeleteConfirmDialog4() {
      bool _withTree = false;
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
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
                      // 依然使用Checkbox组件
                      value: _withTree,
                      onChanged: (bool value) {
                        // 此时context为对话框UI的根Element，我们
                        // 直接将对话框UI对应的Element标记为dirty
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('通过Element Dirty最小改变UI'),
      ),
      body: Center(
        child: OutlineButton(
          onPressed: () => showDeleteConfirmDialog4(),
          child: Text('showDeleteConfirmDialog4'),
        ),
      ),
    );
  }
}
