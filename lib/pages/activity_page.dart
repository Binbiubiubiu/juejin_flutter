import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  ScrollController _controller = ScrollController();

  bool _isShowFloatingBtn = true;

  List _tab = [
    "关注",
    "推荐",
    "热门",
    "开源项目",
    "内部招聘",
    "掘金相亲",
    "上班摸鱼",
    "应用安利",
    "开发工具",
    "New资讯"
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
    return Scaffold(
      body: DefaultTabController(
        length: _tab.length,
        child: CustomScrollView(
//          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              flexibleSpace: PreferredSize(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TabBar(
                            isScrollable: true,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 3.0),
                              ),
                            ),
                            tabs: _tab
                                .map((item) => Tab(
                                      child: Center(
                                        widthFactor: 1.6,
                                        child: Text(item),
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
                  preferredSize: Size.fromHeight(48.0)),
            ),
            new SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: new SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: new Text("List item $index"),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _isShowFloatingBtn
          ? null
          : FloatingActionButton(
              isExtended: false,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.edit),
              onPressed: () {},
            ),
    );
  }
}
