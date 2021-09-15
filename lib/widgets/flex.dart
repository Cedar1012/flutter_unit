/// recommend_page.dart
import 'package:flutter/material.dart';

/// 虚线
///
/// whiteSpace 虚线之间留白距离  默认留白与dashWidth相等
/// dashWidth 线宽度
/// thickness 线粗细
/// color 线颜色
/// direction 横线还是竖线
class FlexWidget extends StatefulWidget {
  final double whiteSpace;
  final double dashWidth;
  final double thickness;
  final Color color;
  final Axis direction;
  const FlexWidget({
    this.whiteSpace,
    this.dashWidth = 3,
    this.thickness = 1,
    this.color = Colors.grey,
    this.direction = Axis.horizontal,
  });
  @override
  _FlexWidgetState createState() => _FlexWidgetState();
}

class _FlexWidgetState extends State<FlexWidget> {
  @override
  void initState() {
    super.initState();
  }

  Widget _dottedLine() => LayoutBuilder(builder: (context, constraints) {
        double distance = widget.direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();

        int lineCount = widget.whiteSpace != null
            ? (distance / (widget.whiteSpace + widget.dashWidth)).floor()
            : (distance / (2 * widget.dashWidth)).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: widget.direction,
          children: List.generate(
            lineCount,
            (index) => SizedBox(
              width: widget.direction == Axis.horizontal
                  ? widget.dashWidth
                  : widget.thickness,
              height: widget.direction == Axis.horizontal
                  ? widget.thickness
                  : widget.dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: widget.color),
              ),
            ),
          ).toList(),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex 虚线"),
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Flex画一条虚线 竖线需要direction设置Aixs.vertical'),
          SizedBox(height: 20),
          _dottedLine(),
        ],
      ),
    );
  }
}
