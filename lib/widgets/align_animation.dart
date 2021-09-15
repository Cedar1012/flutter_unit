import 'dart:math';

import 'package:flutter/material.dart';

class AlignAnimationWidget extends StatefulWidget {
  @override
  _AlignAnimationWidgetState createState() => _AlignAnimationWidgetState();
}

class _AlignAnimationWidgetState extends State<AlignAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animationX;
  double _x = -1.0;
  double _y = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationX = Tween(begin: -1.0, end: 1.5).animate(_controller)
      ..addListener(() {
        setState(() {
          _x = animationX.value;
          _y = f(_x);
        });
      });
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double f(double x) {
    double y = sin(pi * x);
    return y;
  }

  var c1 = Container(
      width: 150,
      height: 150,
      child: MathRunner(
        reverse: false,
        f: (t) => cos(t * pi),
        g: (t) => 0.0 * sin(t * pi),
        child: FlutterLogo(),
      ));

  var c2 = Container(
      width: 150,
      height: 150,
      child: MathRunner(
        reverse: false,
        f: (t) => cos(t * pi),
        g: (t) => 0.6 * sin(t * pi),
        child: FlutterLogo(),
      ));

  var c3 = Container(
      width: 150,
      height: 150,
      child: MathRunner(
        reverse: false,
        f: (t) => cos(t * pi),
        g: (t) => 1 * sin(t * pi),
        child: FlutterLogo(),
      ));

  var c4 = Container(
      width: 150,
      height: 150,
      child: MathRunner(
        reverse: false,
        f: (t) => cos(t * pi),
        g: (t) => 1.5 * sin(t * pi),
        child: FlutterLogo(),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Align + Animation',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _controller.repeat();
                },
                child: Container(
                  width: 300,
                  color: Colors.grey.withAlpha(33),
                  height: 150,
                  child: Align(
                    alignment: Alignment(_x, _y),
                    child: FlutterLogo(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                color: Colors.grey.withAlpha(33),
                height: 150,
                child: MathRunner(
                  child: FlutterLogo(),
                  f: f,
                  g: f,
                  reverse: true,
                ),
              ),
              Stack(
                children: [
                  c1,
                  c2,
                  c3,
                  c4,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

typedef FunNum1 = Function(double t);

class MathRunner extends StatefulWidget {
  MathRunner({Key key, this.child, this.f, this.g, this.reverse = true})
      : super(key: key);
  final Widget child;
  final FunNum1 f;
  final FunNum1 g;
  final bool reverse;

  @override
  _MathRunnerState createState() => _MathRunnerState();
}

class _MathRunnerState extends State<MathRunner>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animationX;
  double _x = -1.0;
  double _y = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationX = Tween(begin: -1.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _x = widget.f(animationX.value);
          _y = widget.g(animationX.value);
        });
      });
    _controller.repeat(reverse: widget.reverse);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.repeat(reverse: widget.reverse);
      },
      child: Container(
        child: Align(
          alignment: Alignment(_x, _y),
          child: widget.child,
        ),
      ),
    );
  }
}
