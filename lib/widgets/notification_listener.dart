import 'package:flutter/material.dart';

class NotificationListenerWidget extends StatefulWidget {
  @override
  _NotificationListenerWidgetState createState() =>
      _NotificationListenerWidgetState();
}

class _NotificationListenerWidgetState
    extends State<NotificationListenerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationListener'),
      ),
      body: Scrollbar(),
    );
  }
}
