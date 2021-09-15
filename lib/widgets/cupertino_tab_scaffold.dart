import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTabScaffoldWidget extends StatelessWidget {
  Widget _render(context, index) {
    print('重新builde');
    print(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Page 1 of tab $index'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Next page'),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text('Page 2 of tab $index'),
                    ),
                    child: Center(
                      child: CupertinoButton(
                        child: const Text('Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'aaa'),
          BottomNavigationBarItem(icon: Icon(Icons.format_paint), label: 'bbb'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ccc')
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        print('page-----$index');
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _render(context, index);
          },
        );
      },
    );
  }
}
