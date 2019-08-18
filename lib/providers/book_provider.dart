import 'package:flutter/material.dart';
import 'package:juejin_app/modal/book_entity.dart';
import 'package:dio/dio.dart';

class BookProvider  with ChangeNotifier {
  BookProvider():super();


  List<BookEntity> _data =[];
  int _pageNum = 1;
  bool _isLoading = false;
  bool _isHasMore = true;

  init(){
    getData(true);
  }

  getData([bool isRefresh=false]) async {
    if(_isLoading)return;
    _isLoading=true;
    if(isRefresh)_pageNum=1;
    notifyListeners();
    try {
      Response response = await Dio().get(
          "https://xiaoce-timeline-api-ms.juejin.im/v1/getListByLastTime?uid=&client_id=&token=&src=web&alias=&pageNum=$_pageNum",
          options: Options(
            responseType: ResponseType.json,
          ));

      List<BookEntity> result = response.data["d"]
          .map<BookEntity>((item) => BookEntity.fromJson(item))
          .toList();
      int statusCode = response.data["s"];
      switch (statusCode) {
        case 1:

          isRefresh ? _data = result : _data.addAll(result);
            _isLoading = false;
            _pageNum = _pageNum + 1;

          break;
        case 2:
          _isHasMore = false;
          break;
        default:
          break;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<BookEntity> get data=>this._data;

  bool get isLoading => _isLoading;

  int get pageNum => _pageNum;

  bool get isHasMore => _isHasMore;
}
