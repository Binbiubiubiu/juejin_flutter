import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:juejin_app/generated/i18n.dart';
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

  List _tabs;

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _tabs = [
      {"label": S.of(context).activity_open_source_project, "topIc": ActivityTopIc.KYTJ},
      {"label": S.of(context).activity_internal_recruitment, "topIc": ActivityTopIc.NTZP},
      {"label": S.of(context).activity_the_nuggets_dating, "topIc": ActivityTopIc.JJXQ},
      {"label": S.of(context).activity_working_fish, "topIc": ActivityTopIc.SBMY},
      {"label": S.of(context).activity_application_of_amway, "topIc": ActivityTopIc.YYAL},
      {"label": S.of(context).activity_development_tools, "topIc": ActivityTopIc.KFGJ},
      {"label": S.of(context).activity_new_information, "topIc": ActivityTopIc.XWZX},
    ];
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
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

class _ActivityTabPageState extends State<ActivityTabPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityProvider>.value(
      key: ValueKey(widget.type),
      value: ActivityProvider(widget.type)..init(),
      child: CustomListView<ActivityProvider>(
        separatorBuilder: (BuildContext context, int index) =>
            Container(height: 10.0),
        itemBuilder: _renderBookItem,
      ),
    );
  }

  Widget _renderBookItem(BuildContext context, int i) {
    var list = Provider.of<ActivityProvider>(context).data;
    if (list.length == 0) return null;
    var entity = list[i];

    return Stack(
        children: <Widget>[
      CustomListItem(
        onTap: () {
          print('11');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              entity.content,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.0),
            entity.url.isEmpty
                ? SizedBox()
                : Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
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
                        color: Color(0x77F5F5F5),
                        border:
                            Border.all(color: Colors.grey[400], width: 0.5)),
                  ),
            entity.pictures != null ? _renderPic(entity.pictures) : SizedBox(),
            SizedBox(height: 10.0),
          ],
        ),
        padding: EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 40.0),
      ),
      ListTile(
        contentPadding: EdgeInsets.only(left: 15.0,right: 10.0),
        leading:entity.user.avatarLarge.isNotEmpty? CircleAvatar(
          backgroundImage: NetworkImage(entity.user.avatarLarge),
        ):SizedBox(),
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
              label: Text(S.of(context).activity_Focus),
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
      Positioned(
        width:MediaQueryData.fromWindow(window).size.width,
        bottom: 29.0,
        left: 0.0,
        child: Divider(indent: 0.0,endIndent: 0.0),
      ),
      Positioned(
        width:MediaQueryData.fromWindow(window).size.width,
        bottom: -5.0,
        left: 0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                textColor: Colors.grey,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/activity/ic_zan_unselect.png"),
                  size: 16.0,
                ),
                label: Text(
                  entity.likedCount != 0
                      ? entity.likedCount.toString()
                      : S.of(context).activity_like,
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.0),
                ),
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                textColor: Colors.grey,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/activity/ic_comment_border.png"),
                  size: 16.0,
                ),
                label: Text(
                  entity.commentCount != 0
                      ? entity.commentCount.toString()
                      : S.of(context).activity_comments,
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.0),
                ),
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                textColor: Colors.grey,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/activity/pin_share_detail.png"),
                  size: 16.0,
                ),
                label: Text(
                  S.of(context).activity_share,
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
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
        result = data[0].isNotEmpty
            ? Container(
                constraints: BoxConstraints(maxWidth: 200.0, maxHeight: 200.0),
                child: Image.network(
                  data[0],
                  fit: BoxFit.contain,
                ),
              )
            : SizedBox();
        break;
      default:
        result = GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          physics: BouncingScrollPhysics(),
          childAspectRatio: 1.0,
          children: data
              .map<Widget>((item) => Image.network(
                    item,
                    fit: BoxFit.contain,
                  ))
              .toList(),
        );
        break;
    }
    return result;
  }
}
