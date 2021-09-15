import 'package:flutter/material.dart';

class ScaffoldDrawerWidget extends StatefulWidget {
  @override
  _ScaffoldDrawerWidgetState createState() => _ScaffoldDrawerWidgetState();
}

class _ScaffoldDrawerWidgetState extends State<ScaffoldDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    Widget _drawer = Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget _endDrawer = SizedBox(
      width: MediaQuery.of(context).size.width * 0.85, //20.0,
      child: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            padding: EdgeInsets.zero,
            children: List.generate(
              150,
              (index) => index == 0
                  ? UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.amberAccent),
                      arrowColor: Colors.redAccent,
                      margin: EdgeInsets.zero,
                      currentAccountPicture: GestureDetector(
                        child: ClipOval(
                            child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.yellow),
                        )),
                      ),
                      otherAccountsPictures: <Widget>[
                        IconButton(
                            icon: Icon(Icons.stars, color: Colors.white),
                            onPressed: () {})
                      ],
                      accountName: Text(
                        '我是Drawer',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      accountEmail: Text('0000@163.com'),
                      onDetailsPressed: () {},
                    )
                  : ListTile(
                      tileColor: index % 2 == 0
                          ? Colors.greenAccent
                          : Colors.blueAccent,
                      title: Text(index.toString() * 10),
                    ),
            ).toList(),
          ),
        ),
      ),
    );

    return Scaffold(
      drawer: _drawer,
      endDrawer: _endDrawer,
      body: Align(
        alignment: Alignment(0.0, 0.0),
        child: Builder(
          builder: (context) => Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                color: Colors.greenAccent,
                child: Text('Open Drawer'),
              ),
              OutlineButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                child: Text('Open End Drawer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
