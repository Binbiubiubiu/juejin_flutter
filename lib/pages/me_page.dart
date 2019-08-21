import 'package:flutter/material.dart';
import 'package:juejin_app/generated/i18n.dart';
import 'package:juejin_app/pages/login_page.dart';
import 'package:juejin_app/providers/i18n_provider.dart';
import 'package:provider/provider.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: _renderListView(),
      ),
    );
  }

  List<Widget> _renderListView() {
    final List list1 = [
      {"icon": "assets/me/ic_notification.png", "title": "消息中心", "action": ""},
      {
        "icon": "assets/me/user_liked_pin.png",
        "title": "我赞过的",
        "action": "215篇"
      },
      {
        "icon": "assets/me/user_collectionset.png",
        "title": "收藏集",
        "action": "1个"
      },
      {"icon": "assets/me/user_buy.png", "title": "已购小册", "action": "0本"},
      {
        "icon": "assets/me/ic_user_data_read.png",
        "title": "阅读过的文章",
        "action": "215篇"
      },
      {"icon": "assets/me/ic_dynamic_tag.png", "title": "标签管理", "action": "80个"}
    ];

    final List list2 = [
      {
        "icon": "assets/me/ic_user_data_read.png",
        "title": "阅读过的文章",
        "action": ""
      },
      {"icon": "assets/me/ic_dynamic_tag.png", "title": "标签管理", "action": ""}
    ];

    List<Widget> _renderList = [
      UserCell(),
      SizedBox(
        height: 10.0,
      )
    ];
    _renderList.addAll(ListTile.divideTiles(
      tiles: list1.map((item) => CellItem(
            icon: item["icon"],
            title: item["title"],
            action: item["action"],
            onTap: () {},
          )),
      color: Colors.grey,
    ).toList());

    _renderList.addAll([
      SizedBox(height: 10.0),
      EveningCellItem(),
    ]);

    _renderList.addAll(ListTile.divideTiles(
      tiles: list2.map((item) => CellItem(
            icon: item["icon"],
            title: item["title"],
            action: item["action"],
            onTap: () {},
          )),
      color: Colors.grey,
    ).toList());

    return _renderList;
  }
}

class CellItem extends StatelessWidget {
  const CellItem({
    Key key,
    this.icon = "",
    this.title = "",
    this.action,
    this.onTap,
  })  : assert(icon != null),
        assert(title != null),
        super(key: key);

  final String title;
  final String icon;

  final String action;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0x10FFFFFF),
      child: ListTile(
        dense: true,
        onTap: onTap,
//          contentPadding: EdgeInsets.all(0),
        leading: Image.asset(
          icon,
          width: 24.0,
        ),
        title: Text(title, style: TextStyle(fontSize: 14.0)),
        trailing: Text(
          action,
          style: TextStyle(
            color: Color(0xFF9A9A9A),
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class EveningCellItem extends StatefulWidget {
  @override
  _EveningCellItemState createState() => _EveningCellItemState();
}

class _EveningCellItemState extends State<EveningCellItem> {
  bool isOk = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0x10FFFFFF),
        border: Border(
          bottom: Divider.createBorderSide(context,width: 1.6, color: Theme.of(context).dividerColor),
        ),
      ),
      child: SwitchListTile(
        dense: true,
        value: Provider.of<I18nProvider>(context).locale.toString() != 'zh_CN',
        onChanged: (val) {
          setState(() {
            isOk = val;
          });
          print(Provider.of<I18nProvider>(context).locale.toLanguageTag());
          Provider.of<I18nProvider>(context)
              .setLocale(val ? Locale("en", "") : Locale("zh", "CN"));
        },
        secondary: Image.asset(
          "assets/me/ic_night.png",
          width: 24.0,
        ),
        title: Text("夜间模式", style: TextStyle(fontSize: 14.0)),
      ),
    );
  }
}

//class EveningCellItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//
//    return Material(
//      color: Colors.white,
//      child: SwitchListTile(
//        dense: true,
//        value: Provider.of<I18nProvider>(context).locale.toLanguageTag()=='zh',
//        onChanged: (val) {
//
//          Provider.of<I18nProvider>(context).setLocale(val?Locale("zh","CN"):Locale("en",""));
//        },
//        secondary: Image.asset(
//          "assets/me/ic_night.png",
//          width: 24.0,
//        ),
//        title: Text("夜间模式", style: TextStyle(fontSize: 14.0)),
//      ),
//    );
//  }
//}

class UserCell extends StatefulWidget {
  @override
  _UserCellState createState() => _UserCellState();
}

class _UserCellState extends State<UserCell> {
  ImageProvider _actor = AssetImage("assets/me/default_avatar.png");

  String _name;
  String _job;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _name = S.of(context).me_login_title_placeholder;
    _job = S.of(context).me_login_subtitle_placeholder;
  }

  void _login() {
    Navigator.of(context)
        .push(
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return LoginPage();
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      }),
    )
        .then((data) {
      if (data == null) return;

      Map<String, String> userInfo = Map.of(data);

      setState(() {
        _name = userInfo["name"];
        _job = userInfo["job"];
        _actor = userInfo["actor"].startsWith("http")
            ? NetworkImage(userInfo["actor"])
            : AssetImage(userInfo["actor"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0x10FFFFFF),
      child: ListTile(
        onTap: _login,
        contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
        leading: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundImage: _actor,
            radius: 20.0,
          ),
        ),
        title: Text(
          '$_name',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18.0,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        subtitle: Text(
          _job,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12.0,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        trailing: Transform(
          transform: Matrix4(0.75, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0,
              1.0, 0.0, 10.0, 0.0, 0.0, 1.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFD3D4D6),
          ),
        ),
      ),
    );
  }
}
