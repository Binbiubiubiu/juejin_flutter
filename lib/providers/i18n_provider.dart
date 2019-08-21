import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class I18nProvider with ChangeNotifier {
  Locale _locale = Locale('zh', 'CN');
  bool _isNight = false;

  get locale => _locale;

  get isNight => _isNight;

  I18nProvider() : super();



  setIsNight(){
    _isNight=!_isNight;
    timeago.setLocaleMessages('en', _isNight?timeago.EnMessages():timeago.ZhCnMessages());
    notifyListeners();
  }


}
