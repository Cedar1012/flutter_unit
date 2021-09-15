import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  Color themeColor = Colors.amber;

  void changeTheme(Color color) {
    this.themeColor = color;
    notifyListeners();
  }
}
