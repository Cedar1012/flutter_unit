import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  @override
  _TransformWidgetState createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  @override
  Widget build(BuildContext context) {
    Widget _matrix4 = Container(
      color: Colors.blueGrey,
      child: Transform(
        alignment: Alignment(0.0, 0.0),
        transform: Matrix4.skewY(0.5),
        child: SizedBox(
          width: 200,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(height: 30),
          Text('画一个倾斜Box'),
          SizedBox(height: 30),
          _matrix4,
        ],
      ),
    );
  }
}
