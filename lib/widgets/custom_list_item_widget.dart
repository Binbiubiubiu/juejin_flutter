import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key key,
    this.onTap,
    this.padding,
    this.child,
    this.height,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final Widget child;
  final EdgeInsets padding;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        radius: 0,
        onTap: onTap,
//        highlightShape:BoxShape.rectangle,
        child: Ink(
          height: height,
          padding: padding,
          child:child,
        ),
      ),
    );
  }
}



