import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  final double elementWidth;
  final double elementHeight;
  final EdgeInsets padding;
  final double minRemainderWidth;
  final double mainAxisSpacing;
  final List<Widget> children;
  const GridViewWidget({
    this.elementHeight,
    this.elementWidth,
    this.children,
    this.padding,
    this.minRemainderWidth = 20,
    this.mainAxisSpacing,
  });

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Widget _gridView() {
    // 去掉GridView两侧边距的屏幕宽度
    double screen = MediaQuery.of(context).size.width -
        (widget.padding != null
            ? (widget.padding?.left ?? 0 + widget.padding?.right ?? 0)
            : 0);
    // 一行显示的元素个数
    double rouCertificateCount = screen / widget.elementWidth;
    // 一行剩余的宽度
    double remainder = screen % widget.elementWidth;
    // 元素之间 横向中间空隙距离
    // remainder求余之后的宽度 如果小于minRemainderWidth 则减去一个widget的宽度作为空白
    double average = remainder < widget.minRemainderWidth
        ? remainder + widget.elementWidth / (rouCertificateCount.floor() - 2)
        : remainder / (rouCertificateCount.floor() - 1);

    return GridView(
      padding: widget.padding == null ? EdgeInsets.zero : widget.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // remainder求余之后的宽度 如果小于minRemainderWidth 则减去一个widget的宽度作为空白
        crossAxisCount: rouCertificateCount.floor() -
            (remainder < widget.minRemainderWidth ? 1 : 0),
        crossAxisSpacing: average,
        mainAxisSpacing:
            widget.mainAxisSpacing != null ? widget.mainAxisSpacing : average,
        childAspectRatio: widget.elementWidth / widget.elementHeight,
      ),
      children: widget.children,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("GridView"),
          centerTitle: true,
        ),
        body: _gridView());
  }
}
