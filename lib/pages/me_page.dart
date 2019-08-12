import 'package:flutter/material.dart';

class MePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('我'),
        centerTitle: true,
      ),
      body: ListView(
        children: _renderListView(),
      ),
    );
  }

  List<Widget> _renderListView(){

    final List list1 = [
      {"icon": "assets/me/ic_notification.png", "title": "消息中心", "action": ""},
      {"icon": "assets/me/user_liked_pin.png", "title": "我赞过的", "action": "215篇"},
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

    final List list2=[
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
      Divider(height: 1.0,),
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
      color: Colors.white,
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

class EveningCellItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SwitchListTile(
        dense: true,
        value: false,
        onChanged: (val) {},
        secondary: Image.asset(
          "assets/me/ic_night.png",
          width: 24.0,
        ),
        title: Text("夜间模式", style: TextStyle(fontSize: 14.0)),
      ),
    );
  }
}

class UserCell extends StatefulWidget {
  @override
  _UserCellState createState() => _UserCellState();
}

class _UserCellState extends State<UserCell> {
  ImageProvider _actor = AssetImage("assets/me/default_avatar.png");

  String _name = "登录/注册";
  String _job = "添加职位@ 添加公司";

  void _login() {
    Navigator.of(context).pushNamed('/login').then((data) {
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
      color: Colors.white,
      child: ListTile(
        onTap: _login,
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
          style: TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          _job,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.0),
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
