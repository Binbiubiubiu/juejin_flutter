import 'package:flutter/material.dart';
import 'package:juejin_app/modal/article_entity.dart';
import 'package:dio/dio.dart';

class ArticleType {
  static const POPULAR = 'POPULAR';
  static const NEWEST ='NEWEST';
  static const THREE_DAYS_HOTTEST = 'THREE_DAYS_HOTTEST';
}

class ArticleProvider with ChangeNotifier {
  ArticleProvider(
    this.articleType,
  ) : super();

  final String articleType;

  List<ArticleEntity> _data = [];
  dynamic _pageNum = "";
  bool _isLoading = false;
  bool _isHasMore = false;

  init() {
    getData(true);
  }

  getData([bool isRefresh = false]) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    if (isRefresh) _pageNum = "";
    try {
      Response response = await Dio().post(
        "https://web-api.juejin.im/query",
        data: {
          "operationName": "",
          "query": "",
          "variables": {"first": 20, "after": _pageNum, "order": articleType},
          "extensions": {
            "query": {"id": "21207e9ddb1de777adeaca7a2fb38030"}
          }
        },
        options: Options(
          headers: {"X-Agent": "Juejin/Web"},
        ),
      );
      List<ArticleEntity> result = response.data['data']["articleFeed"]["items"]
              ["edges"]
          .map<ArticleEntity>((item) => ArticleEntity.fromJson(item["node"]))
          .toList();

      if (_pageNum == "") {
        _data = result;
      } else {
        _data.addAll(result);
      }
      _pageNum = response.data['data']["articleFeed"]["items"]['pageInfo']
          ['endCursor'];
      _isHasMore = response.data['data']["articleFeed"]["items"]['pageInfo']
          ['hasNextPage'];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<ArticleEntity> get data => this._data;

  bool get isLoading => _isLoading;

  int get pageNum => _pageNum;

  bool get isHasMore => _isHasMore;
}
