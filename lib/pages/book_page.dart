import 'package:flutter/material.dart';
import 'package:juejin_app/generated/i18n.dart';

import 'package:juejin_app/widgets/custom_list_view_widget.dart';
import 'package:juejin_app/widgets/custom_list_item_widget.dart';
import 'package:juejin_app/modal/book_entity.dart';
import 'package:provider/provider.dart';
import 'package:juejin_app/providers/book_provider.dart';

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(S.of(context).book_all),
                  ),
                ),
                Tab(
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(S.of(context).book_already_bought),
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

class _BookTabPageState extends State<BookTabPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookProvider>.value(
      value: BookProvider()..init(),
      child: CustomListView<BookProvider>(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey,
          height: 1,
        ),
        itemBuilder: (context, index) =>
            _renderBookItem(Provider.of<BookProvider>(context).data[index]),
      ),
    );
  }

  Widget _renderBookItem(BookEntity book) {

    return CustomListItem(
      onTap: () {
        print("book");
      },
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(1.0, 2.0),
                  blurRadius: 6.0),
            ]),
            child: Image.network(
              book.img,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.0),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: book.userData.username,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.title.color,
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
                                  height: 12.0,
                                ),
                        ),
                      ),
                    ]),
                  ),
//                  SizedBox(height: 4.0),
                  Text(
                    "${book.lastSectionCount} 小节 · ${book.buyCount}人已购买",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                  Expanded(child: Container(),)
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

}
