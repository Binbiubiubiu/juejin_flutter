import 'package:flutter/material.dart';
import 'package:juejin_app/providers/activity_provider.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:juejin_app/widgets/custom_list_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  ScrollController _controller = ScrollController();

  bool _isShowFloatingBtn = true;
  static const KYTJ = '5c09ea2b092dcb42c740fe73';
  static const NTZP = '5abb61e1092dcb4620ca3322';
  static const JJXQ = '5abcaa67092dcb4620ca335c';
  static const SBMY = '5c106be9092dcb2cc5de7257';
  static const YYAL = '5b514af1092dcb61bd72800d';
  static const KFGJ = '5abb67d2092dcb4620ca3324';
  static const XWZX = '5c46a17f092dcb4737217152';

  List _tabs = [
    {"label": "关注", "topIc": ActivityTopIc.KYTJ},
    {"label": "推荐", "topIc": ActivityTopIc.NTZP},
    {"label": "热门", "topIc": ActivityTopIc.JJXQ},
    {"label": "开源项目", "topIc": ActivityTopIc.KYTJ},
    {"label": "内部招聘", "topIc": ActivityTopIc.NTZP},
    {"label": "掘金相亲", "topIc": ActivityTopIc.JJXQ},
    {"label": "上班摸鱼", "topIc": ActivityTopIc.SBMY},
    {"label": "应用安利", "topIc": ActivityTopIc.YYAL},
    {"label": "开发工具", "topIc": ActivityTopIc.KFGJ},
    {"label": "New资讯", "topIc": ActivityTopIc.XWZX},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      print(_controller.offset);
      setState(() {
        _isShowFloatingBtn = _controller.offset > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0),
                    ),
                  ),
                  tabs: _tabs
                      .map((item) => Tab(
                            child: Center(
                              widthFactor: 1.6,
                              child: Text(item['label']),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                width: 50.0,
                child: FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
            children: _tabs
                .map((item) => ActivityTabPage(
                      type: item['topIc'],
                    ))
                .toList()),
        floatingActionButton: _isShowFloatingBtn
            ? null
            : FloatingActionButton(
                isExtended: false,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.edit),
                onPressed: () {},
              ),
      ),
    );
  }
}

class ActivityTabPage extends StatefulWidget {
  ActivityTabPage({
    Key key,
    this.type,
  }) : super(key: key);

  final String type;

  @override
  _ActivityTabPageState createState() => _ActivityTabPageState();
}

class _ActivityTabPageState extends State<ActivityTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityProvider>.value(
      key: ValueKey(widget.type),
      value: ActivityProvider(widget.type)..init(),
      child: CustomListView<ActivityProvider>(
        separatorBuilder: (BuildContext context, int index) =>
            Container(color: Colors.grey[200], height: 10.0),
        itemBuilder: _renderBookItem,
      ),
    );
  }

  Widget _renderBookItem(BuildContext context, int i) {
    var list = Provider.of<ActivityProvider>(context).data;
    if (list.length == 0) return null;
    var entity = list[i];

    return Stack(children: <Widget>[
      CustomListItem(
        onTap: () {
          print("book");
        },
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: 15.0, right: 5.0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(entity.user.avatarLarge),
            ),
            title: Text(entity.user.username),
            subtitle: Text(
              "${entity.user.jobTitle} @ ${entity.user.company}  ${timeago.format(DateTime.parse(entity.updatedAt))}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            dense: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OutlineButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  textColor: Colors.green,
                  highlightedBorderColor: Colors.green,
                  borderSide: BorderSide(color: Colors.green),
                  label: Text("关注"),
                ),
                RawMaterialButton(
                  padding: EdgeInsets.all(10.0),
                  constraints: BoxConstraints(minHeight: 50.0, minWidth: 0.0),
                  shape: CircleBorder(
                      side: BorderSide(width: 50.0, color: Colors.transparent)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/home/ic_pin_more.png", width: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entity.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
//                  entity.folded?Text(
//                    "查看详情",
//                    style: TextStyle(color: Colors.blue),
//                    textAlign: TextAlign.left,
//                  ):SizedBox(),
                SizedBox(height: 10.0),
                entity.url.isEmpty
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 0.0),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            entity.urlTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            entity.url,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Image.network(
                            entity.urlPic,
                            height: double.infinity,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(
                                color: Colors.grey[400], width: 0.5)),
                      ),
                entity.pictures != null
                    ? _renderPic(entity.pictures)
                    : SizedBox(),
              ],
            ),
          ),
          Divider(height: 1.0),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton.icon(
                  textColor: Colors.grey,
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/activity/ic_zan_unselect.png"),
                    size: 18.0,
                  ),
                  label: Text(
                    entity.likedCount != 0 ? entity.likedCount.toString() : "赞",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton.icon(
                  textColor: Colors.grey,
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/activity/ic_comment_border.png"),
                    size: 18.0,
                  ),
                  label: Text(
                    entity.commentCount != 0
                        ? entity.commentCount.toString()
                        : "评论",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton.icon(
                  textColor: Colors.grey,
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/activity/pin_share_detail.png"),
                    size: 18.0,
                  ),
                  label: Text(
                    "分享",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    ]);
  }

  Widget _renderPic(data) {
    var result;
    switch (data.length) {
      case 0:
        result = SizedBox();
        break;
      case 1:

        result =data[0].isNotEmpty? Container(
                constraints: BoxConstraints(maxWidth: 200.0, maxHeight: 200.0),
                child: Image.network(
                  data[0],
                  fit: BoxFit.contain,
                ),
              )
            : SizedBox();
        break;
      default:
        result =  GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            physics: BouncingScrollPhysics(),
            childAspectRatio: 1.0,
            children: data
                .map<Widget>((item) =>Image.network(
              item,
              fit: BoxFit.contain,
            ))
                .toList(),
          );
        break;
    }
    return result;
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
