import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:juejin_app/providers/article_provider.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:juejin_app/widgets/custom_list_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExplorePage extends StatelessWidget {
  final double _divideHeight = 0.5;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
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
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
              ),
            ],
          ),
        ),
      ),
      body: ChangeNotifierProvider<ArticleProvider>.value(
        key: ValueKey(ArticleType.THREE_DAYS_HOTTEST),
        value: ArticleProvider(ArticleType.THREE_DAYS_HOTTEST)..init(),
        child: ExploreCardList(),
      ),
    );
  }
}

class ExploreCardList extends StatefulWidget {
  @override
  _ExploreCardListState createState() => _ExploreCardListState();
}

class _ExploreCardListState extends State<ExploreCardList> {
  final double _divideHeight = 1.0;
  final List<String> _bannarList = [
    "banner.jpeg",
    "bannar2.jpeg",
  ];

  ArticleProvider _provider;
  ScrollController _scrollController;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      _provider.getData(true);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(getMoreData);
  }

  getMoreData() {
    if (!_provider.isLoading && _scrollController.position.extentAfter == 0.0) {
      _provider.getData(false);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _provider = Provider.of<ArticleProvider>(context);
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController.dispose();
      _scrollController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: [],
    );

    var list = Provider.of<ArticleProvider>(context).data;

    list.forEach((item) {
      column.children
        ..add(Divider(
          height: 1.0,
        ))
        ..add(CustomListItem(
          key: ValueKey(item.id),
          height: 100.0,
          onTap: () {
            print(11);
          },
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "${item.likeCount}人喜欢 · ${item.user.username} · ${timeago.format(DateTime.parse(item.createdAt))}",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              item.screenshot != null && item.screenshot.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      child: Image.network(
                        item.screenshot,
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ));
    });

    return ListView(
      controller: _scrollController,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1080 / 350,
          child: Swiper(
            itemBuilder: (BuildContext context, int i) {
              return Image.asset(
                "assets/explore/${_bannarList[i]}",
                fit: BoxFit.fill,
              );
            },
            itemCount: 2,
          ),
        ),
        Divider(height: _divideHeight),
        ExploreTabBtnBar(),
        Divider(height: _divideHeight),
        SizedBox(height: 10.0),
        _renderTop(),
        column,
        _buildListLoadingMore(),
      ],
    );
  }

  //渲染列表加载更多组件
  Widget _buildListLoadingMore() {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      child: _provider.isHasMore
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
            ),
          ),
          SizedBox(width: 20.0),
          Text("加载中...")
        ],
      )
          : Text("没有更多内容"),
    );
  }

  Widget _renderTop() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Image.asset("assets/explore/explorer_hot_small.png", height: 20.0),
          SizedBox(width: 8.0),
          Expanded(child: Text("热门文章")),
          GestureDetector(
            child: Row(
              children: <Widget>[
                Image.asset("assets/explore/explorer_tag_settings.png",
                    height: 20.0),
                SizedBox(width: 4.0),
                Text("定制热门")
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class ExploreCard extends StatelessWidget {
  ExploreCard(this.title, this.subtitle, this.imgUrl, {Key key})
      : super(key: key);

  final String title;
  final String subtitle;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return CustomListItem(
      onTap: () {
        print(11);
      },
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Image.network(
            imgUrl,
            height: 70.0,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}

class ExploreTabBtnBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ExploreTabBtn("文章榜", "explorer_entry_board.png"),
          ExploreTabBtn("作者榜", "explorer_user_board.png"),
          ExploreTabBtn("看一看", "explorer_followee_liked.png", tag: "99+"),
          ExploreTabBtn("话题广场", "explorer_topic_square.png"),
          ExploreTabBtn("活动", "explorer_entry_board.png"),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

class ExploreTabBtn extends StatelessWidget {
  const ExploreTabBtn(
    this.title,
    this.icon, {
    Key key,
    this.onTap,
    this.tag = "",
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onTap;
  final String tag;

  Widget _renderTag() {
    return Positioned(
      right: 0.0,
      child: (tag != null && tag.isNotEmpty
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                tag,
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            )
          : Container()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: 64.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 6.0),
                Image.asset(
                  "assets/explore/$icon",
                  width: 40.0,
                ),
                SizedBox(height: 6.0),
                Text(title),
              ],
            ),
          ),
          _renderTag(),
        ],
      ),
    );
  }
}
