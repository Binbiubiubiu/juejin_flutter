import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';

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
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1080 / 350,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  "assets/explore/banner.jpeg",
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
          ExploreCardList(),
        ],
      ),
    );
  }
}

class ExploreCardList extends StatefulWidget {
  @override
  _ExploreCardListState createState() => _ExploreCardListState();
}

class _ExploreCardListState extends State<ExploreCardList> {
  final double _divideHeight = 0.5;

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

//  Widget _renderLoadingMore() {
//    return Center(
//      heightFactor: 2.6,
//      child: CircularProgressIndicator(
//        strokeWidth: 4.0,
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          Divider(height: _divideHeight),
          _renderTop(),
          Divider(height: _divideHeight),
          ExploreCard("Vuejs建议和最佳实践", "19人赞 · pilishen · 2小时前",
              "https://user-gold-cdn.xitu.io/2019/8/6/16c64f8dd56f4e4f?imageView2/1/w/120/h/120/q/85/format/webp/interlace/1"),
          Divider(height: _divideHeight),
          ExploreCard("Vuejs建议和最佳实践", "19人赞 · pilishen · 2小时前",
              "https://user-gold-cdn.xitu.io/2019/8/6/16c64f8dd56f4e4f?imageView2/1/w/120/h/120/q/85/format/webp/interlace/1"),
          Divider(height: _divideHeight),
          ExploreCard("Vuejs建议和最佳实践", "19人赞 · pilishen · 2小时前",
              "https://user-gold-cdn.xitu.io/2019/8/6/16c64f8dd56f4e4f?imageView2/1/w/120/h/120/q/85/format/webp/interlace/1"),
          Divider(height: _divideHeight),
          ExploreCard("Vuejs建议和最佳实践", "19人赞 · pilishen · 2小时前",
              "https://user-gold-cdn.xitu.io/2019/8/6/16c64f8dd56f4e4f?imageView2/1/w/120/h/120/q/85/format/webp/interlace/1"),
          Divider(height: _divideHeight),
//          _renderLoadingMore(),
        ],
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
      onTap: () {print(11);},
      bottomSide: BorderSide.none,
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
