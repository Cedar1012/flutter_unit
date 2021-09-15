import 'dart:math';

import 'package:flutter/material.dart';

class FlowWidget extends StatefulWidget {
  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  final sides = [60.0, 50.0, 40.0, 30.0];
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  Widget _box(Widget wg) => Center(
        child: Container(
            width: 200,
            height: 200,
            color: Colors.grey.withAlpha(66),
            alignment: Alignment.center,
            child: wg),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flow'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _box(
            AngleFlow(
              children: sides.map((e) => _buildItem(e)).toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _box(
            CircleFlow(
              children: sides.map((e) => _buildItem(e)).toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _box(
            BurstFlow(
              children: sides.map((e) => _buildItem(e)).toList(),
              menu:
                  Container(width: 20, height: 20, color: Colors.yellowAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(double e) {
    return Container(
      width: e,
      alignment: Alignment.center,
      height: e,
      color: colors[sides.indexOf(e)],
      child: Text('$e'),
    );
  }
}

class CircleFlow extends StatefulWidget {
  final List<Widget> children;
  CircleFlow({this.children});

  @override
  _CircleFlowState createState() => _CircleFlowState();
}

class _CircleFlowState extends State<CircleFlow>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double rad = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 3000), vsync: this)
          ..addListener(() => setState(() => rad = _controller.value * pi * 2));

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(rad),
      children: widget.children,
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  final double rad;
  _CircleFlowDelegate(this.rad);

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;
      var offsetX = (radius - cSizeX) * cos(i * perRad + rad) + radius;
      var offsetY = (radius - cSizeY) * sin(i * perRad + rad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}

class AngleFlow extends StatelessWidget {
  final List<Widget> children;

  AngleFlow({this.children}) : assert(children.length == 4);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _AngleDelegate(),
      children: children,
    );
  }
}

class _AngleDelegate extends FlowDelegate {
  Matrix4 m4;

  @override
  void paintChildren(FlowPaintingContext context) {
    var size = context.size;
    for (int i = 0; i < context.childCount; i++) {
      var cSize = context.getChildSize(i);
      if (i == 1) {
        m4 = Matrix4.translationValues(size.width - cSize.width, 0, 0.0);
      } else if (i == 2) {
        m4 = Matrix4.translationValues(0, size.height - cSize.height, 0.0);
      } else if (i == 3) {
        m4 = Matrix4.translationValues(
            size.width - cSize.width, size.height - cSize.height, 0.0);
      }
      context.paintChild(i, transform: m4);
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}

class BurstFlow extends StatefulWidget {
  final List<Widget> children;
  final Widget menu;

  BurstFlow({this.children, this.menu});

  @override
  _BurstFlowState createState() => _BurstFlowState();
}

class _BurstFlowState extends State<BurstFlow>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _rad = 0.0;
  bool _closed = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this)
      ..addListener(() => setState(
          () => _rad = (_closed ? (_controller.value) : 1 - _controller.value)))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _closed = !_closed;
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegatea(_rad),
      children: [
        ...widget.children,
        InkWell(
            onTap: () {
              _controller.repeat();
              // _controller.reset();
              // _controller.forward();
            },
            child: widget.menu)
      ],
    );
  }
}

class _CircleFlowDelegatea extends FlowDelegate {
  final double rad;
  _CircleFlowDelegatea(this.rad);

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount - 1;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;
      var offsetX = rad * (radius - cSizeX) * cos(i * perRad) + radius;
      var offsetY = rad * (radius - cSizeY) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
            radius - context.getChildSize(context.childCount - 1).width / 2,
            radius - context.getChildSize(context.childCount - 1).height / 2,
            0.0));
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
