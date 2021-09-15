import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterWidget extends StatefulWidget {
  @override
  _CustomPainterWidgetState createState() => _CustomPainterWidgetState();
}

class _CustomPainterWidgetState extends State<CustomPainterWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double percent = 100;
  double pass = 3;
  double fail = 1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: (0), end: (percent)).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CustomPainter'),
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.center,
              children: [
                Plate(percent: pass / (pass + fail), radius: 120),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 247, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(188)),
                    ),
                    height: 208,
                    width: 208,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(197, 229, 253, 1),
                        borderRadius: BorderRadius.all(Radius.circular(158)),
                      ),
                      height: 178,
                      width: 178,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(91, 159, 247, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(128)),
                          ),
                          height: 158,
                          width: 158,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '73',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class Plate extends StatefulWidget {
  final double percent;
  final double radius;

  const Plate({Key key, this.percent, this.radius}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PlateState();
}

class PlateState extends State<Plate> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation =
        Tween<double>(begin: (0), end: (widget.percent)).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              painter: PlatePainter(
                animation.value,
                radius: widget.radius,
              ),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: 0.75 * pi + 1.5 * pi * animation.value,
              child: Container(
                width: 262,
                height: 50,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       child: Image.asset(
                //         'images/indicator.png',
                //         fit: BoxFit.contain,
                //       ),
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           BoxShadow(
                //             color: Color(0x5CA07300),
                //             offset: Offset(1, 0),
                //             blurRadius: 10.0,
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlatePainter extends CustomPainter {
  final double percent;
  final double radius;

  PlatePainter(this.percent, {this.radius = 120});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    var paint2 = Paint()..style = PaintingStyle.fill;
    var paint3 = Paint()
      ..color = Color.fromRGBO(68, 132, 241, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    //draw arc
    canvas.drawArc(
        Offset(-radius, -radius) & Size(2 * radius, 2 * radius),
        0.75 * pi, //radians
        1.5 * pi * percent, //radians
        false,
        paint1..color = Color.fromRGBO(68, 132, 241, 1));

    canvas.drawArc(
        Offset(-radius, -radius) & Size(2 * radius, 2 * radius),
        0.75 * pi + 1.5 * pi * percent, //radians
        1.5 * pi * (1 - percent), //radians
        false,
        paint1..color = Color.fromRGBO(222, 235, 252, 1));

    // 线抹点圆角
    // canvas.drawCircle(Offset(-radius / pow(2, 0.5), radius / pow(2, 0.5)), 5,
    //     paint2..color = Color(0xFF4EC9B6));

    // canvas.drawCircle(Offset(radius / pow(2, 0.5), radius / pow(2, 0.5)), 5,
    //     paint2..color = Color(0xFFFFBF1C));

    double angle = 0.75 * pi;
    while (angle < 0.75 * pi + 1.5 * pi * 1.28 * pi * (1 - percent)) {
      var x = cos(angle) * (radius + 23) + radius;
      var y = sin(angle) * (radius + 23) + radius;
      canvas.drawLine(
        Offset(x, y) + Offset(-radius, -radius),
        Offset(x - cos(angle) * 10, y - sin(angle) * 10) +
            Offset(-radius, -radius),
        paint3,
      );
      angle = angle + pi / 60;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
