import 'package:flutter/material.dart';
import 'package:juejin_app/modal/activity_entity.dart';
import 'package:dio/dio.dart';

class ActivityTopIc{
  static const KYTJ = '5c09ea2b092dcb42c740fe73';
  static const NTZP ='5abb61e1092dcb4620ca3322';
  static const JJXQ = '5abcaa67092dcb4620ca335c';
  static const SBMY = '5c106be9092dcb2cc5de7257';
  static const YYAL = '5b514af1092dcb61bd72800d';
  static const KFGJ = '5abb67d2092dcb4620ca3324';
  static const XWZX = '5c46a17f092dcb4737217152';
}


class ActivityProvider with ChangeNotifier {
  ActivityProvider(
    this.topIc,
  ) : super();

  final String topIc;

  List<ActivityEntity> _data = [];
  dynamic _pageNum = 0;
  bool _isLoading = false;
  bool _isHasMore = false;

  init() {
    getData(true);
  }

  getData([bool isRefresh = false]) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    if (isRefresh) _pageNum = 1;
//    try {
      Response response = await Dio().get(
        "https://short-msg-ms.juejin.im/v1/pinList/topic",
        queryParameters: {
          "uid": "596d53b96fb9a06bbe7de6e9",
          "device_id": "1565515014986",
          "token": "eyJhY2Nlc3NfdG9rZW4iOiJaOEFtZ0dXZkJNb1ZWbkZ5IiwicmVmcmVzaF90b2tlbiI6ImtSTzJmdjFObnY2blVIYmoiLCJ0b2tlbl90eXBlIjoibWFjIiwiZXhwaXJlX2luIjoyNTkyMDAwfQ==",
          "src": "web",
          "topicId":topIc,
          "page":_pageNum,
          "pageSize":20,
          "sortType":"rank"
        },
      );
      List<ActivityEntity> result = response.data['d']['list']
          .map<ActivityEntity>((item) => ActivityEntity.fromJson(item))
          .toList();

      if (_pageNum ==0) {
        _data = result;
      } else {
        _data.addAll(result);
      }
      _pageNum ++;
      _isHasMore = true;
      _isLoading = false;
      notifyListeners();
//    } catch (e) {
//      print(e);
//    }
  }

  List<ActivityEntity> get data => this._data;

  bool get isLoading => _isLoading;

  int get pageNum => _pageNum;

  bool get isHasMore => _isHasMore;
}
