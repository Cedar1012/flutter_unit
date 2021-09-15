import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/widgets/utils.dart';

class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  ScrollController _scrollController = ScrollController();
  int _listLevelIndex = 0;
  final double ITEM_WIDTH = 84;

  @override
  void initState() {
    super.initState();
  }

  Widget _listLevel(int index, bool isShowLine) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              double screenWidth = MediaQuery.of(context).size.width;
              setState(() {
                _listLevelIndex = index;
                _scrollController.animateTo(
                    index * ITEM_WIDTH - screenWidth / 2 + 36.5,
                    duration: new Duration(milliseconds: 300),
                    curve: Curves.ease);
              });
            },
            child: Container(
              color: Utils.randomColor(),
              width: 53,
              height: 58,
              alignment: Alignment.center,
              child: Text(
                index.toString(),
                style: TextStyle(color: Utils.randomColor(), fontSize: 20),
              ),
            ),
          ),
          SizedBox(width: 4),
          Offstage(
            offstage: !isShowLine,
            child: Container(
              width: 23,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Color(0x995F5F5F),
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: !isShowLine,
            child: SizedBox(width: 4),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              _listLevelIndex.toString(),
              style: TextStyle(
                color: Utils.randomColor(),
                fontSize: 100,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.red,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 58,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                children: List.generate(
                  55,
                  (index) => _listLevel(index, index == 54 ? false : true),
                ).toList(),
              ),
            ),
            SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(index.toString() * 10),
                    tileColor: Utils.randomColor(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
