import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:juejin_app/modal/book_entity.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              isScrollable: true,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 3.0),
                ),
              ),
              tabs: <Widget>[
                Tab(
                  child: Center(
                    widthFactor: 2.0,
                    child: Text("全部"),
                  ),
                ),
                Tab(
                  child: Center(
                    widthFactor: 2.0,
                    child: Text("已购"),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BookTabPage(),
            BookTabPage(initPageNum: 10),
          ],
        ),
      ),
    );
  }
}

class BookTabPage extends StatefulWidget {
  const BookTabPage({
    Key key,
    this.initPageNum = 1,
  }) : super(key: key);

  final int initPageNum;

  @override
  _BookTabPageState createState() => _BookTabPageState();
}

class _BookTabPageState extends State<BookTabPage> with AutomaticKeepAliveClientMixin{
  List<BookEntity> _list = [];
  ScrollController _scrollController = new ScrollController();
  int _pageNum = 1;
  bool _isLoading = false;
  bool _isFinished = false;

  Key _refreshKey;

  Future<Null> _refresh() async {
    print("refresh");
    await Future.delayed(Duration(seconds: 3), () {
      getData(widget.initPageNum, true);
    });
  }

  void getData(int pageNum, [bool isRefresh = false]) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://xiaoce-timeline-api-ms.juejin.im/v1/getListByLastTime?uid=&client_id=&token=&src=web&alias=&pageNum=$pageNum",
          options: Options(
            responseType: ResponseType.json,
          ));

      if (response.data["s"] == 1) {
      } else {
        _isFinished = true;
      }
      List<BookEntity> result = response.data["d"]
          .map<BookEntity>((item) => BookEntity.fromJson(item))
          .toList(growable: true);

      int statusCode = response.data["s"];
      switch (statusCode) {
        case 1:
          setState(() {
            isRefresh ? _list = result : _list.addAll(result);
            _isLoading = false;
            _pageNum = pageNum + 1;
          });
          break;
        case 2:
//          double edge = 60.0;
//          double offsetFromBottom = _scrollController.position.maxScrollExtent -
//              _scrollController.position.pixels;
//          if (offsetFromBottom < edge) {
//            _scrollController.animateTo(
//                _scrollController.offset - (edge - offsetFromBottom),
//                duration: new Duration(milliseconds: 500),
//                curve: Curves.easeOut);
//          }

          setState(() {
            _isFinished = true;
          });
          break;
        default:
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (!_isLoading &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        getData(_pageNum);
//        print("LOADINGMORE");
      }
    });

//    ScrollStartNotification(context: context).dispatch(context);
    getData(widget.initPageNum);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _refresh,
      child: _list.length == 0
          ? LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight + 10.0,
                  ),
                  alignment: Alignment(0, -0.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset("assets/book/placeholder_no_xiaoce.png",
                          width: 80.0),
                      Text("暂无已购小册", style: TextStyle(color: Colors.grey[400]))
                    ],
                  ),
                ),
              );
            })
          : ListView.builder(
//              cacheExtent: 2000.0,
              itemCount: _list.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return _list.length != 0 && index == _list.length
                    ? _renderLoadingMore()
                    : Column(
                        children: <Widget>[
                          _renderBookItem(index),
                          Divider(height: 1.0)
                        ],
                      );
              },
              controller: _scrollController,
            ),
    );
  }

  Widget _renderLoadingMore() {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      child: _isFinished
          ? Text("没有更多内容")
          : Row(
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
            ),
    );
  }

  Widget _renderBookItem(int i) {
    BookEntity book;
    try {
      book = _list[i];
    } catch (e) {
      return Container();
    }

    return CustomListItem(
      onTap: () {
        print("book");
      },
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      bottomSide: BorderSide.none,
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(1.0, 2.0),
                  blurRadius: 6.0),
            ]),
            child: CachedNetworkImage(
              imageUrl:book.img,
              width: 60.0,
            ),
          ),
          SizedBox(
            width: 14.0,
          ),
          Expanded(
            child: SizedBox(
              height: 86.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,),maxLines: 2,
                  ),
                  SizedBox(height: 4.0),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: book.userData.username,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 1.6),
                          child: book.userData.level == null ||
                                  "${book.userData.level}".isEmpty
                              ? Text("")
                              : Image.asset(
                                  "assets/book/ic_user_big_lv${book.userData.level}.png",
                                  height: 10.0,
                                ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "${book.lastSectionCount} 小节 · ${book.buyCount}人已购买",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Chip(

            padding: EdgeInsets.symmetric(horizontal: 8.0),
            label: Text(
              "¥${book.price}",
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xff0077ff),
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color(0xfff0f7ff),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
