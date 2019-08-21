import 'package:flutter/material.dart';
import 'package:juejin_app/providers/i18n_provider.dart';
import 'package:provider/provider.dart';

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
      color: Provider.of<I18nProvider>(context).isNight
          ? Color(0x10ffffff)
          : Color(0xffffffff),
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



