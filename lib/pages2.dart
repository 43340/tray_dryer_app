import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  final Widget chill;

  Page2({Key key, this.chill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: chill,
    );
  }
}
