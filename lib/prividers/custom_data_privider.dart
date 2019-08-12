import 'package:flutter/material.dart';

class CustomDataPrivider extends InheritedWidget {
  const CustomDataPrivider({
    Key key,
    this.theme,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final CustomThemeData theme;

  static CustomDataPrivider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CustomDataPrivider)
        as CustomDataPrivider;
  }

  @override
  bool updateShouldNotify(CustomDataPrivider old) {
    return true;
  }
}


class CustomThemeData {
   Color customListItemBg;
   Color customListItemActiveBg;

  CustomThemeData({
    this.customListItemBg,
    this.customListItemActiveBg,
  });
}
