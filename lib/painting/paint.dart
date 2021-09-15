import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/painting/cp.dart';

class PaintPage extends StatelessWidget {
// 测试 isAntiAlias 和 color属性
  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(180, 180),
        170,
        paint
          ..color = Colors.blue
          ..strokeWidth = 5);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        170,
        paint
          ..isAntiAlias = false
          ..color = Colors.red);
  }

  // 测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(
        Offset(180, 180),
        150,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        150,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
    //测试线
    canvas.drawLine(
        Offset(0, 180 - 150.0),
        Offset(1600, 180 - 150.0),
        paint
          ..strokeWidth = 1
          ..color = Colors.blueAccent);
  }

  void drawStrokeCap(Canvas canvas) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(
        Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(50 + 50.0, 50), Offset(50 + 50.0, 150),
        paint..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(50 + 50.0 * 2, 50), Offset(50 + 50.0 * 2, 150),
        paint..strokeCap = StrokeCap.square);
  }

  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50 + 150.0, 50);
    path.lineTo(50 + 150.0, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50 + 150.0 * 2, 50);
    path.lineTo(50 + 150.0 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paint')),
      body: Column(
        children: [
          CPW(drawStyleStrokeWidth),
          CPW(drawStrokeCap),
          CPW(drawStrokeJoin),
        ],
      ),
    );
  }
}
