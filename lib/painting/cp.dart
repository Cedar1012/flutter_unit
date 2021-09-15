import 'package:flutter/cupertino.dart';

class CPW extends StatelessWidget {
  final Function fun;
  const CPW(this.fun);
  @override
  Widget build(BuildContext context) => CustomPaint(painter: CustomM(fun));
}

class CustomM extends CustomPainter {
  final Function fun;
  const CustomM(this.fun);

  @override
  void paint(Canvas canvas, Size size) => fun(canvas);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
