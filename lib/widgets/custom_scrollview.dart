import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomScrollViewWidget extends StatefulWidget {
  @override
  _CustomScrollViewWidgetState createState() => _CustomScrollViewWidgetState();
}

class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;
  bool isShowTb = true;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    scrollController = ScrollController();
    scrollController.addListener(() {
      // print(scrollController.offset);
      // if (scrollController.offset > 1756.4582973576269) {
      //   setState(() {
      //     isShowTb = false;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20),
            sliver: SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
          SliverPersistentHeader(
            // 可以吸顶的TabBar
            pinned: isShowTb,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                indicatorColor: Colors.red,
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            // 剩余补充内容TabBarView
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
          SliverPersistentHeader(
            delegate: _MySliverPersistentHeaderDelegate(),
            pinned: true,
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: this.child);
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent = 140;
  final double _maxExtent = 300;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //创建child子组件
    //shrinkOffset：child偏移值minExtent~maxExtent
    //overlapsContent：SliverPersistentHeader覆盖其他子组件返回true，否则返回false
    print('shrinkOffset = $shrinkOffset overlapsContent = $overlapsContent');

    return _ItemContainer();
  }

  //SliverPersistentHeader最大高度
  @override
  double get maxExtent => _maxExtent;

  //SliverPersistentHeader最小高度
  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _ItemContainer extends StatefulWidget {
  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<_ItemContainer> {
  int cIndex = 0;

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 2 / 16;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: List.generate(
            16,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  cIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: index == cIndex ? 0 : 60),
                width: itemWidth,
                decoration: BoxDecoration(
                  color: index > 8
                      ? Colors.yellow[100 * (16 - index) + 100]
                      : Colors.green[100 * index + 100],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
