import 'dart:ui';

import 'package:flutter/material.dart';

class PngStackShadePage extends StatefulWidget {
  @override
  _PngStackShadePageState createState() => _PngStackShadePageState();
}

class _PngStackShadePageState extends State<PngStackShadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PNG 图片 Stack 阴影'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment(0.0, 0.0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    // Container(
                    //   color: Colors.red,
                    //   width: 100,
                    //   height: 100,
                    // ),
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'images/package.png',
                        color: Colors.black,
                      ),
                    ),
                    // BackdropFilter 需要 CliRect包裹 否则无法约束 BackdropFilter区域
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 105.0, sigmaY: 30.0),
                        child: Image.asset(
                          'images/package.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Text('0' * 10000),
                    Center(
                      child: ClipRect(
                        // <-- clips to the 200x200 [Container] below
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 200.0,
                            height: 200.0,
                            child: const Text('Hello World'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
