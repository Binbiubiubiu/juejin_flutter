import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomListView<T> extends StatefulWidget {
  const CustomListView({
    Key key,
    this.itemBuilder,
    this.separatorBuilder,
    this.hasController = true,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;

  final IndexedWidgetBuilder separatorBuilder;

  final hasController;

  @override
  _CustomListViewState<T> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView> {

  var provider;
  ScrollController _scrollController;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      provider.getData(true);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.hasController) {
//      _scrollController = new ScrollController();
//      _scrollController.addListener(getMoreData);
    }
  }

  getMoreData() {
    if (!provider.isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      provider.getData(false);
    }
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    provider = Provider.of<T>(context);
  }

  @override
  void didUpdateWidget(CustomListView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: provider.data.length == 0
          ? _buildListEmptyTip()
          : NotificationListener(
              onNotification: _listenLoadMore,
              child: ListView.separated(
                addAutomaticKeepAlives: true,
                itemCount: provider.isHasMore
                    ? provider.data.length + 1
                    : provider.data.length,
                separatorBuilder: widget.separatorBuilder,
                itemBuilder: (BuildContext context, int i) {
                  return provider.isHasMore && i == provider.data.length
                      ? _buildListLoadingMore()
                      : widget.itemBuilder(context, i);
                },
//                controller: _scrollController,
              ),
            ),
    );
  }

  bool _listenLoadMore(notification){
    switch(notification.runtimeType){
      case ScrollEndNotification:
        if(notification.metrics.extentAfter == 0.0){
          provider.getData(false);
        }
        break;
      default:
        break;
    }
    return false;
  }

  //渲染空列表组件
  Widget _buildListEmptyTip() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight + 10.0,
          ),
          alignment: Alignment(0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("assets/book/placeholder_no_xiaoce.png", width: 80.0),
              Text("暂无内容", style: TextStyle(color: Colors.grey[400]))
            ],
          ),
        ),
      );
    });
  }

  //渲染列表加载更多组件
  Widget _buildListLoadingMore() {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      child: provider.isHasMore
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
}
