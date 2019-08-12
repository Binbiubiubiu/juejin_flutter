import 'package:flutter/material.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:juejin_app/pages/webview_page.dart';
import 'package:dio/dio.dart';
import 'package:juejin_app/modal/article_entity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController();

  bool _isShowFloatingBtn = true;

  List<ArticleEntity> _list = [];

  void getData(int first) async {
    try {
      Response response = await Dio().post("https://web-api.juejin.im/query",
          data: {
            "operationName": "",
            "query": "",
            "variables": {"first": first, "after": "", "order": "POPULAR"},
            "extensions": {
              "query": {"id": "21207e9ddb1de777adeaca7a2fb38030"}
            }
          },
          options: Options(
            headers: {"X-Agent": "Juejin/Web"},
            responseType: ResponseType.json,
          ));
//      print(response.data['data']["articleFeed"]["items"]["edges"]);
      setState(() {
        _list = response.data['data']["articleFeed"]["items"]["edges"]
            .map<ArticleEntity>((item) => ArticleEntity.fromJson(item["node"]))
            .toList(growable: true);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _refresh() async {
    print("refresh");
    await Future.delayed(Duration(seconds: 3), () {
      getData(20);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isShowFloatingBtn = _controller.offset > 0;
      });
    });

    getData(20);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
//          controller: _controller,
          cacheExtent: 1200,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      color: Color.fromRGBO(255, 255, 255, 0.16),
                      textColor: Colors.white,
                      highlightColor: Color.fromRGBO(255, 255, 255, 0.4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "搜索文章、用户、标签",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/home/ic_setting_white.png",
                          width: 16.0,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "标签",
                          style: TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TabBar(
                        isScrollable: true,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 3.0),
                          ),
                        ),
                        tabs: <Widget>[
                          Tab(
                            child: Center(
                              widthFactor: 1.6,
                              child: Text("关注"),
                            ),
                          ),
                          Tab(
                            child: Center(
                              widthFactor: 1.6,
                              child: Text("推荐"),
                            ),
                          ),
                          Tab(
                            child: Center(
                              widthFactor: 1.6,
                              child: Text("热榜"),
                            ),
                          )
                        ],
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
                  preferredSize: Size.fromHeight(48.0)),
            ),
            RefreshIndicator(
              child: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  print(index);
                  ArticleEntity entity;
                  try {
                    entity = _list[index];
                  } catch (e) {
                    print(e);
                    return Container();
                  }

                  return CustomListItem(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return WebViewPage(
                          title: entity.title,
                          url: entity.originalUrl,
                        );
                      }));
                    },
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      radius: 12.0,
                                      backgroundImage:
                                          NetworkImage(entity.user.avatarLarge),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Listener(
//                                          onTapUp: (TapUpDetails detail){print(11);},
                                      onPointerDown: (PointerDownEvent event) {
                                        print(11);
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Ink(
                                        height: 24.0,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(entity.user.username),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entity.tags
                                    .map((item) => item.title)
                                    .toList()
                                    .join(" / "),
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${entity.title}\n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(
                                          height: 22.0,
                                        ),
//                                              style: TextStyle(height: 5),
                                      ),
                                      TextSpan(
                                        text: entity.content,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              entity.screenshot == null ||
                                      entity.screenshot.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Image.network(
                                          entity.screenshot,
                                          fit: BoxFit.cover,
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                      ),
                            ],
                          ),

                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Ink(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTapDown: null,
                                onTap: () {
                                  print(11);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Image.asset(
                                        "assets/home/ic_zan_unselect.png",
                                        width: 20.0),
                                    SizedBox(width: 2.0),
                                    Text(
                                      "${entity.likeCount}",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Ink(
                              child: GestureDetector(
                                behavior: HitTestBehavior.deferToChild,
                                onTapDown: (TapDownDetails details) {
                                  print(11);
                                },
                                child: InkWell(
//                                  onTap: (){print(22);},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Image.asset(
                                          "assets/home/ic_comment_border.png",
                                          width: 20.0),
                                      SizedBox(width: 2.0),
                                      Text(
                                        "${entity.commentsCount}",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }, childCount: _list.length),
              ),
              onRefresh: _refresh,
            ),
          ],
        ),
      ),
      floatingActionButton: _isShowFloatingBtn
          ? null
          : FloatingActionButton(
              isExtended: false,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add),
              onPressed: () {},
            ),
    );
  }
}
