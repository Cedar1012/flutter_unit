import 'package:flutter/material.dart';
import 'package:flutter_tabbar_state/widgets/utils.dart';

class ClipPathWidget extends StatefulWidget {
  @override
  _ClipPathWidgetState createState() => _ClipPathWidgetState();
}

class _ClipPathWidgetState extends State<ClipPathWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClipPath"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              // 圆形裁剪
              ClipPath(
                clipper: ShapeBorderClipper(
                  shape: CircleBorder(),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Utils.randomColor()),
                  child: FlutterLogo(size: 100),
                ),
              ),
              SizedBox(height: 10),
              // 圆角矩形裁剪
              ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Utils.randomColor()),
                  child: FlutterLogo(size: 100),
                ),
              ),

              SizedBox(height: 10),
              ClipPath.shape(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Utils.randomColor()),
                  child: FlutterLogo(size: 100),
                ),
              ),

              SizedBox(height: 10),
              ClipPath(
                clipper: TriangleClipper(),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Utils.randomColor()),
                  child: FlutterLogo(size: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    Path path = Path()
      ..moveTo(0, size.height)
      ..relativeLineTo(size.width, 0)
      ..relativeLineTo(-size.width / 2, -size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
