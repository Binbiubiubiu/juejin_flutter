import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:juejin_app/modal/article_entity.dart';
import 'package:juejin_app/providers/article_provider.dart';
import 'package:juejin_app/widgets/custom_list_view_widget.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isShowFloatingBtn = true;

  final _tabList = [
    {"label": "热门", "type": ArticleType.POPULAR},
    {"label": "最新", "type": ArticleType.NEWEST},
    {"label": "热榜", "type": ArticleType.THREE_DAYS_HOTTEST},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabList.length,
        child: NestedScrollView(
            headerSliverBuilder: (context, isInerBoxScroll) => [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                titleSpacing: 0.0,
                title: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: FlatButton(
                    onPressed: () {},
                    color: Color.fromRGBO(255, 255, 255, 0.16),
                    textColor: Colors.white,
                    highlightColor: Color.fromRGBO(255, 255, 255, 0.4),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "搜索文章、用户、标签",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(255, 255, 255, 0.4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0.0),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
                bottom: PreferredSize(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TabBar(
                          isScrollable: true,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                          tabs: _tabList
                              .map((item) => Tab(
                                    child: Center(
                                      widthFactor: 1.6,
                                      child: Text(item["label"]),
                                    ),
                                  ))
                              .toList()),
                      SizedBox(width: 50.0)
                    ],
                  ),
                  preferredSize: Size.fromHeight(48.0),
                ),
              ),
            ],
            body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: TabBarView(
                children: _tabList
                    .map((item) => ArticleTabPage(type: item['type']))
                    .toList(),
              ),
            ),
          ),

      ),
      floatingActionButton: _isShowFloatingBtn
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            )
          : null,
    );
  }


}

class ArticleTabPage extends StatefulWidget {
  ArticleTabPage({
    Key key,
    this.type,
  }) : super(key: key);

  final String type;

  @override
  _ArticleTabPageState createState() => _ArticleTabPageState();
}

class _ArticleTabPageState extends State<ArticleTabPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArticleProvider>.value(
      key: ValueKey(widget.type),
      value: ArticleProvider(widget.type)..init(),
      child: CustomListView<ArticleProvider>(
        separatorBuilder: (BuildContext context, int index) =>
            Container(color: Colors.grey[200], height: 10.0),
        itemBuilder: _renderBookItem,
      ),
    );
  }

  Widget _renderBookItem(BuildContext context, int i) {
    var list = Provider.of<ArticleProvider>(context).data;
    if (list.length == 0) return null;
    var entity = list[i];

    return Stack(
      children: <Widget>[
        CustomListItem(
          key: ValueKey(entity.id),
          onTap: () {
            print("book");
          },
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 45.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 12.0,
                        backgroundImage: NetworkImage(entity.user.avatarLarge),
                      ),
                      SizedBox(width: 5.0),
                      Text(entity.user.username),
                    ],
                  ),
                  Text(
                    entity.tags.map((item) => item.title).toList().join(" / "),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      softWrap: true,
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
                          TextSpan(
                            text: "1\n",
                            style: TextStyle(
                              fontSize: 4.0,
                            ),
                          ),
                          TextSpan(
                            text: entity.content,
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  entity.screenshot == null || entity.screenshot.isEmpty
                      ? Material()
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
            ],
          ),
        ),
        Positioned(
          left: 10.0,
          bottom: -25.0,
          child: Row(
            children: <Widget>[
              RawMaterialButton(
                padding: EdgeInsets.all(10.0),
                constraints: BoxConstraints(minHeight: 50.0, minWidth: 0.0),
                shape: CircleBorder(
                    side: BorderSide(width: 50.0, color: Colors.transparent)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/home/ic_zan_unselect.png", width: 16.0),
                    SizedBox(width: 2.0),
                    Text(
                      "${entity.likeCount == 0 ? '点赞' : entity.likeCount}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              RawMaterialButton(
                padding: EdgeInsets.all(10.0),
                constraints: BoxConstraints(minHeight: 100.0, minWidth: 10.0),
                shape: CircleBorder(
                    side: BorderSide(width: 50.0, color: Colors.transparent)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/home/ic_comment_border.png",
                        width: 16.0),
                    SizedBox(width: 2.0),
                    Text(
                      "${entity.commentsCount == 0 ? '评论' : entity.commentsCount}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
