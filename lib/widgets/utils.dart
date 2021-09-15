import 'dart:math';
import 'dart:ui';

class Utils {
  static Color randomColor() => Color.fromARGB(
        255,
        Random().nextInt(256) + 0,
        Random().nextInt(256) + 0,
        Random().nextInt(256) + 0,
      );
}
