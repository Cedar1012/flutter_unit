import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Wrap(
        children: [
          CustomPaint(
            painter: PaperPainter(),
          ),
          CustomPaint(
            painter: PaperLinePainter(),
          ),
          CustomPaint(
            painter: PaintPainter(),
          ),
        ],
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    final Paint paint = Paint();
    // 绘制圆
    canvas.drawCircle(Offset(100, 100), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PaperLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint(); // 创建画笔
    paint
      ..color = Colors.blue //颜色
      ..strokeWidth = 4 //线宽
      ..style = PaintingStyle.stroke; //模式--线型
    canvas.drawLine(Offset(100, 100), Offset(200, 200), paint); //绘制线
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PaintPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint(); // 创建画笔
    paint
      ..color = Colors.blue //颜色
      ..strokeWidth = 4 //线宽
      ..style = PaintingStyle.stroke; //模式--线型
    //英雄所见...
    Path path = Path();
    path.moveTo(200, 200);
    path.lineTo(300, 100);
    canvas.drawPath(path, paint..color = Colors.red);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
