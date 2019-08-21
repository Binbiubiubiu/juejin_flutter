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
          S.of(context).me_title,
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: _renderListView(context),
      ),
    );
  }

  List<Widget> _renderListView(BuildContext context) {
    final List<dynamic> list1 = [
      {
        "icon": "assets/me/ic_notification.png",
        "title": S.of(context).me_message_center,
        "action": ""
      },
      {
        "icon": "assets/me/user_liked_pin.png",
        "title": S.of(context).me_my_like,
        "action": "215"
      },
      {
        "icon": "assets/me/user_collectionset.png",
        "title": S.of(context).me_collection,
        "action": "1"
      },
      {
        "icon": "assets/me/user_buy.png",
        "title": S.of(context).me_already_bought_small_volumes,
        "action": "0"
      },
      {
        "icon": "assets/me/ic_user_data_read.png",
        "title": S.of(context).me_read_the_article,
        "action": "215"
      },
      {
        "icon": "assets/me/ic_dynamic_tag.png",
        "title": S.of(context).me_label_management,
        "action": "80"
      }
    ];

    final List<dynamic> list2 = [
      "switchlTile",
      {
        "icon": "assets/me/icon_feed_back.png",
        "title": S.of(context).me_feedback,
        "action": ""
      },
      {
        "icon": "assets/me/settings.png",
        "title": S.of(context).me_setting,
        "action": ""
      }
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
    ]);

    _renderList.addAll(ListTile.divideTiles(
      tiles: list2.map((item) => item == 'switchlTile'
          ? EveningCellItem()
          : CellItem(
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
      color: Provider.of<I18nProvider>(context).isNight
          ? Color(0x10ffffff)
          : Color(0xffffffff),
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
    return Material(
      color: Provider.of<I18nProvider>(context).isNight
          ? Color(0x10ffffff)
          : Color(0xffffffff),
      child: SwitchListTile(
        dense: true,
        value: Provider.of<I18nProvider>(context).isNight,
        onChanged: (val) {
          setState(() {
            isOk = val;
          });
          Provider.of<I18nProvider>(context)
              .setIsNight();
        },
        secondary: Image.asset(
          "assets/me/ic_night.png",
          width: 24.0,
        ),
        title: Text(
            isOk ? S.of(context).me_day_mode : S.of(context).me_night_mode,
            style: TextStyle(fontSize: 14.0)),
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
      color: Provider.of<I18nProvider>(context).isNight
          ? Color(0x10ffffff)
          : Color(0xffffffff),
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
