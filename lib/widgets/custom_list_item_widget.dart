import 'package:flutter/material.dart';
import 'package:juejin_app/prividers/custom_data_privider.dart';

class CustomListItem extends StatefulWidget {
  CustomListItem({
    Key key,
    this.onTap,
    this.padding,
    BorderSide bottomSide,
    this.child,
  })
      : this.bottomSide =
      bottomSide ?? BorderSide(width: 10.0, color: Colors.grey[100]),
        super(key: key);

  final GestureTapCallback onTap;
  final Widget child;
  final EdgeInsets padding;
  final BorderSide bottomSide;

  @override
  _CustomListItemState createState() => _CustomListItemState();

}

class _CustomListItemState extends State<CustomListItem>  {
  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bgColor = Colors.white;
  }


  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: widget.padding,
      decoration: BoxDecoration(
          color: _bgColor, border: Border(bottom: widget.bottomSide)),
      child:GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onPointerDown: (PointerDownEvent event){print("121");},
        onTap: widget.onTap,
//        onTap: widget.onTap,
        onTapDown: (TapDownDetails details) {
          setState(() {
            this._bgColor =
                CustomDataPrivider
                    .of(context)
                    .theme
                    .customListItemActiveBg;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            this._bgColor = CustomDataPrivider
                .of(context)
                .theme
                .customListItemBg;
          });
        },
        onTapCancel: () {
          setState(() {
            this._bgColor = CustomDataPrivider
                .of(context)
                .theme
                .customListItemBg;
          });
        },
      child: widget.child,
      ),
    );
  }

}
